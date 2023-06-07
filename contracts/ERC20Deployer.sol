// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ERC20Template.sol";


contract ERC20Deployer {

    event DeployERC20Event(address indexed owner, address indexed token);

    mapping(address => address[]) deployed;

    function DeployERC20(string memory name, string memory symbol, uint256 totalSupply) public returns (address){
        address contract_address = address(new ERC20Template(name,symbol,totalSupply,msg.sender));
        deployed[msg.sender].push(contract_address);
        emit DeployERC20Event(msg.sender, contract_address);
        return contract_address;
    }

    function getERC20(address owner) public view returns (address[] memory) {
        return deployed[owner];
    }
}