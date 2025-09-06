
const HflToken = artifacts.require("./HflToken.sol");
const Exchange = artifacts.require("./Exchange.sol");

const ETHER_ADDRESS = '0x0000000000000000000000000000000000000000';


const fromWei = (bn) => web3.utils.fromWei(bn, 'ether');

const toWei = (num) => web3.utils.toWei(num.toString(), 'ether');

module.exports = async function (callback) {

    const hflToken = await HflToken.deployed();
    const exchange = await Exchange.deployed();
    const accounts = await web3.eth.getAccounts();


    // await exchange.withdrawEther(toWei(5), {
    //     from: accounts[0]
    // });

    // let res1 = await exchange.tokens(ETHER_ADDRESS, accounts[0]);
    // console.log(fromWei(res1));

    await exchange.withdrawToken(hflToken.address,toWei(50000), {
        from: accounts[0]
    });

     let res2 = await exchange.tokens(hflToken.address, accounts[0]);
    console.log(fromWei(res2));

    // // 1. 查询交易所合约的ETH余额
    // const ethBalanceWei = await web3.eth.getBalance(exchange.address);
    // console.log("\n1. 交易所合约的ETH余额:", web3.utils.fromWei(ethBalanceWei, 'ether'), "ETH");

    // // 2. 查询交易所合约持有的HFLToken总额 (通过查询代币合约)
    // const exchangeHflBalanceWei = await hflToken.balanceOf(exchange.address);
    // console.log("2. 交易所合约持有的HFL总额:", web3.utils.fromWei(exchangeHflBalanceWei, 'ether'), "HFL");



    callback();
    
}