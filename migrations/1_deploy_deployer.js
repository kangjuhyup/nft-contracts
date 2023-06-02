const NFTDeployer = artifacts.require("NFTDeployer");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(NFTDeployer);
};
