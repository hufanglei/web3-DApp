pragma solidity >= 0.4.16 < 0.9.0;


contract HflToken {


    string public name = "HFLToken";

    string public symbol = "HFL";

    uint256 public decimals = 18;
 
    uint256 public totalSupply;

    // mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public balanceOf;

    mapping(address => mapping(address => uint256)) public allowance; //定量定额

    constructor() {
        // totalSupply = _initialSupply * 10 ** decimals;
        totalSupply = 1000000 * (10 ** decimals);
        // 部署账号
        balanceOf[msg.sender] = totalSupply;
    }
 
    // 触发 区块链日志 事件监听
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    function transfer(address _to,  uint256 _value) public returns (bool success) {
        require(_to!=address(0));
        // require(balanceOf[msg.sender] >= _value);
        // balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);  // 调用者余额减少
        // balanceOf[_to] = balanceOf[msg.sender].add(_value); // 接收者余额增加   
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function _transfer(address _from, address _to,  uint256 _value) internal {
        require(_to!=address(0));
        require(balanceOf[_from] >= _value);
        // 从哪个账号发起的调用者
        balanceOf[_from] = balanceOf[_from] - _value;  // 调用者余额减少
        balanceOf[_to] = balanceOf[_to] + _value; // 接收者余额增加   

        // 触发事件
        emit Transfer(_from, _to, _value);
    }   


    function approve(address _spender, uint256 _value) public returns (bool success) {
        // msg.sender 当前网页登陆的账号
        // _spender 授权的账号 第三方的交易所的账号地址
        // _value 授权的金额
        require(_spender != address(0));
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        // // return true;
        // _approve(msg.sender, _spender, _value);
        return true;
    }

    function _approve(address _owner, address _spender, uint256 _value) internal {
        allowance[_owner][_spender] = _value;
    }


   // 被授权的交易所调用
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
       // _from 某个放款账号
       // _to 接收账号
       // msg.sender 交易所账户 地址       
        require(balanceOf[_from]  >= _value);
        require(allowance[_from][msg.sender]>=_value);
        // allowance[_from][msg.sender] = allowance[_from][msg.sender] - _value;
        _approve(_from, msg.sender, allowance[_from][msg.sender] - _value);
        _transfer(_from, _to, _value);
        return true;
    }







}