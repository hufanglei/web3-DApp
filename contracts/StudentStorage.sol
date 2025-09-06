pragma solidity >= 0.4.16 < 0.9.0;

contract StudentStorage {

   // 结构体
    struct Student {
        uint id;
        string name;
        uint age;
    }

    // 动态数组
    Student[] public StudentList; // 自动gettter()

    // 创建 2个变量，username,age
    string  public name;
    uint public  age;
    
    // struct ，动态数组，映射，string
    function addList(string memory _name, uint _age) public returns (uint) {
        uint count = StudentList.length;
        uint index = count + 1;
        // string memory a; // 局部变量，存储在内存中
        StudentList.push(Student(index, _name, _age));
        return StudentList.length;
    }

    // function test(uint x, uint y) public pure returns (uint) {
    //     return x + y;
    // }

    // view （视图函数，只访问不修改状态）， pure（纯函数，不访问，也不修改）
    function getList() public view returns (Student[] memory) {
        Student[] memory list = StudentList;
        return list;
    }


}