
const Contracts  = artifacts.require("HflToken.sol");
const Exchange  = artifacts.require("Exchange.sol");

module.exports = async function (deployer) {

   const accounts = await web3.eth.getAccounts();
   const deployerAddress = accounts[0];
   
   await deployer.deploy(Contracts);
   await deployer.deploy(Exchange, deployerAddress, 10);
}