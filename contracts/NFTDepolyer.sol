// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./NFTTemplate.sol";


contract NFTDeployer {

    event DeployNFTEvent(address indexed owner, address indexed nft);

    mapping(address => address[]) deployed;

    function DeployNFT(string memory name, string memory symbol, string memory baseUri) public returns (address){
        address contract_address = address(new NFTTemplate(name,symbol,baseUri));
        deployed[msg.sender].push(contract_address);
        emit DeployNFTEvent(msg.sender, contract_address);
        return contract_address;
    }

    function getNFT(address owner) public view returns (address[] memory) {
        return deployed[owner];
    }
}