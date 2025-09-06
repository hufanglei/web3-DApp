
const Contracts  = artifacts.require("HflToken.sol");

module.exports = function (deployer) {
   deployer.deploy(Contracts);
}