// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract ERC20Deployer {

  event DeployERC20Event(address indexed owner, address indexed erc20);

  mapping(address => address[]) deployed;

  function deployERC20(bytes memory bytecode) public {
    bytes memory data = abi.encodeWithSignature("transferOwnership(address)", msg.sender);
    address contractB;
    assembly {
      contractB := create(0, add(bytecode, 0x20), mload(bytecode))
      if iszero(contractB) {
          returndatacopy(0, 0, returndatasize())
          revert(0, returndatasize())
      }

      let success := call(gas(), contractB, 0, add(data, 0x20), mload(data), 0, 0)
      if iszero(success) {
        returndatacopy(0, 0, returndatasize())
        revert(0, returndatasize())
      }
    }
    deployed[msg.sender].push(contractB);
    emit DeployERC20Event(msg.sender, contractB);
  }

  function getERC20(address owner) public view returns (address[] memory) {
    return deployed[owner];
  }
}