// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract TokenPINKFLOYD is ERC20 {
    constructor(uint256 initialSupply) ERC20("PINKFLOYD", "PINK") {
        _mint(msg.sender, initialSupply);
    }
}
