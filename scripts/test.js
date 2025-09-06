
const Contracts = artifacts.require("./StudentStorage.sol");

module.exports = async function (callback) {
    console.log("111111");
    console.log("---------");
    const studentStorage = await Contracts.deployed();
    await studentStorage.setData("hufl", 200);
    let res = await studentStorage.getData();
    console.log(res);
    console.log(await studentStorage.name());
    console.log(await studentStorage.age());
    callback();
    
}