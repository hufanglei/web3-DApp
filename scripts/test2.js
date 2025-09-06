
const Contracts = artifacts.require("./StudentListStorage.sol");

module.exports = async function (callback) {
    // console.log("111111");
    // console.log("---------");
    const studentStorage = await Contracts.deployed();


    await studentStorage.addList("hufl", 20);
    let res = await studentStorage.getList();
    console.log(res);

    console.log(await studentStorage.StudentList(2));
    callback();
    
}