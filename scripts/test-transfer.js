
const Contracts = artifacts.require("./HflToken.sol");

const fromWei = (bn) => web3.utils.fromWei(bn, 'ether');

const toWei = (num) => web3.utils.toWei(num.toString(), 'ether');

module.exports = async function (callback) {

    const HflToken = await Contracts.deployed();
    let from_acount = "0xcB25Df0C235B07dF6B7282773c392dD02167e9EF";
    let to_acount = "0x4b06bC0c34d3b1884B32Bd3295D483e0071C6D1a";
    // 测试第一个账号的余额
    let res1 = await HflToken.balanceOf(from_acount);
    console.log("第一个账号:", fromWei(res1));

    let res11 = await HflToken.balanceOf(to_acount);
    console.log("第二个账号:", fromWei(res11));

    console.log("---------转账开始---------");

    await HflToken.transfer(to_acount, toWei(10000), {
        from: from_acount
    });

    console.log("---------转账结束---------");

    let res2 = await HflToken.balanceOf(from_acount);
    console.log("第一个账号:", fromWei(res2));

    let res3 = await HflToken.balanceOf(to_acount);
    console.log("第二个账号:", fromWei(res3));



    // 测试第二个账号的余额
    callback();
    
}