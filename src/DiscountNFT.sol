// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract DiscountNFT is ERC721Enumerable {
    uint256 public nextTokenId;
    mapping(uint256 => uint256) public discounts;

    constructor() ERC721("DiscountNFT", "DNFT") {}

    function mintNFT(address _to, uint256 _discount) public returns (uint256) {
        require(_discount <= 20, "Discount must be 20% or less");

        uint256 tokenId = nextTokenId;
        nextTokenId++;

        _mint(_to, tokenId);
        discounts[tokenId] = _discount;

        return tokenId;
    }

    function getDiscount(uint256 _tokenId) public view returns (uint256) {
        require(_tokenId < nextTokenId);
        return discounts[_tokenId];
    }
}
