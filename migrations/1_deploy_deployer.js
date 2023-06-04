const NFTDeployer = artifacts.require("NFTDeployer");
const ERC20Deployer = artifacts.require("ERC20Deployer");
module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(NFTDeployer);
  deployer.deploy(ERC20Deployer);
};
