// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenPINKFLOYD.sol";
import "./TokenRHCP.sol";
import "./DiscountNFT.sol";

contract TokenSwap {
    TokenPINKFLOYD public tokenPINK;
    TokenRHCP public tokenRHCP;
    DiscountNFT public discountNFT;

    address public seller;
    address public buyer;

    constructor(
        address _tokenPINK,
        address _tokenRHCP,
        address _discountNFT,
        address _seller,
        address _buyer
    ) {
        tokenPINK = TokenPINKFLOYD(_tokenPINK);
        tokenRHCP = TokenRHCP(_tokenRHCP);
        discountNFT = DiscountNFT(_discountNFT);
        seller = _seller;
        buyer = _buyer;
    }

    function beforeSwap(address account) public view returns (uint256) {
        uint256 balance = discountNFT.balanceOf(account);
        if (balance > 0) {
            uint256 tokenId = discountNFT.tokenOfOwnerByIndex(account, 0);
            return discountNFT.getDiscount(tokenId);
        }
        return 0;
    }

    function swapAllTokens() public {
        require(msg.sender == buyer);

        uint256 buyerRHCPBalance = tokenRHCP.balanceOf(buyer);
        uint256 sellerPINKBalance = tokenPINK.balanceOf(seller);

        uint256 discount = beforeSwap(buyer);

        uint256 adjustedBuyerRHCPBalance = buyerRHCPBalance * (100 - discount) / 100;

        require(adjustedBuyerRHCPBalance > 0, "Buyer has no RHCP tokens to swap");
        require(sellerPINKBalance > 0, "Seller has no PINKFLOYD tokens to swap");

        tokenRHCP.transferFrom(buyer, seller, adjustedBuyerRHCPBalance);

        tokenPINK.transferFrom(seller, buyer, sellerPINKBalance);
    }
}
