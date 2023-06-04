// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20Template is ERC20, Ownable {
    constructor(string memory name, string memory symbol, address owner, uint256 totalSupply) ERC20(name, symbol) {
        _mint(owner,totalSupply);
    }
}