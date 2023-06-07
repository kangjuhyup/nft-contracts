// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract _ERC20Deployer {

  event DeployERC20Event(address indexed owner, address indexed erc20);

  function getBytesCode(bytes memory bytecode, string memory name, string memory symbol,address owner, uint256 totalSupply) public view returns(bytes memory) {
    bytes memory pack = abi.encodePacked(bytecode,abi.encode(name,symbol,owner,totalSupply));
    return pack;
  }

  function deployERC20(bytes memory bytecode, string memory name, string memory symbol, uint256 totalSupply) public {
    bytes memory pack =  getBytesCode(bytecode, name, symbol,msg.sender,totalSupply);
    bytes memory data = abi.encodeWithSignature("transferOwnership(address)", msg.sender);
    address contractB;
    assembly {
      contractB := create(0, add(pack, 0x20), mload(pack))
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
    emit DeployERC20Event(msg.sender, contractB);
  }
}