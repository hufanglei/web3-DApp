pragma solidity >=0.4.16 <0.9.0;

import "./HflToken.sol";

contract Exchange {
    // 收费账户地址
    address public feeAccount;
    // 费率百分比
    uint256 public feePercent;

    // 存储以太坊地址
    address constant ETHER = address(0);

    // 存储用户地址和代币地址
    mapping(address => mapping(address => uint256)) public tokens;


    // 订单结构体
    struct _Order {
        uint256 id;
        address user;
        address tokenGet;
        uint256 amountGet;

        address tokenGive;
        uint256 amountGive;

        uint256 timestamp;
    }

    // _Order[] public orderlist;

    mapping(uint256 => _Order) public orders;

    mapping(uint256 => bool) public orderCancel;

    uint256 public orderCount;

    // 构造函数
    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }

    // 存以太币
    function depositEther() public payable {
        // msg.sender
        // msg.value
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender] + msg.value;
        emit Deposit(ETHER, msg.sender, msg.value, tokens[ETHER][msg.sender]);
    }

    event Deposit(address token, address user, uint256 amount, uint256 balance);

    event WithDraw(
        address token,
        address user,
        uint256 amount,
        uint256 balance
    );

    // 创建订单事件
    event Order(
        uint256 id,
        address user,
        address tokenGet,
        uint256 amountGet,
        address tokenGive,
        uint256 amountGive,
        uint256 timestamp
    );

    // 取消订单事件
    event Cancel(
        uint256 id,
        address user,
        address tokenGet,
        uint256 amountGet,
        address tokenGive,
        uint256 amountGive,
        uint256 timestamp
    );


    // 存其他货币
    function depositToken(address _token, uint256 _amount) public {
        require(_token != ETHER);
        // 调用某个方法强行从你账户往当前交易所账户转钱
        require(
            HflToken(_token).transferFrom(msg.sender, address(this), _amount)
        );
        tokens[_token][msg.sender] = tokens[_token][msg.sender] + _amount;
        emit Deposit(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    // 提取以太币
    function withdrawEther(uint256 _amount) public {
        require(tokens[ETHER][msg.sender] >= _amount);
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender] - _amount;
        // 从当前合约地址往用户地址转账
        payable(msg.sender).transfer(_amount);

        emit WithDraw(ETHER, msg.sender, _amount, tokens[ETHER][msg.sender]);
    }

    // 提取其他货币
    function withdrawToken(address _token, uint256 _amount) public {
        require(_token != ETHER);
        require(tokens[_token][msg.sender] >= _amount);

        tokens[_token][msg.sender] = tokens[_token][msg.sender] - _amount;
        // 从当前合约地址往用户地址转账
        require(HflToken(_token).transfer(msg.sender, _amount));
        emit WithDraw(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    // 查余额
    function balanceOf(
        address _token,
        address _user
    ) public view returns (uint256) {
        return tokens[_token][_user];
    }

    // makeOrder
    function makeOrder(address _tokenGet,
        uint256 _amountGet,
        address _tokenGive,
        uint256 _amountGive) public {
        orderCount = orderCount + 1;
        orders[orderCount] = _Order(orderCount, msg.sender, _tokenGet, _amountGet, _tokenGive, _amountGive, block.timestamp);

        // 发出订单
        emit Order(orderCount, msg.sender, _tokenGet, _amountGet, _tokenGive, _amountGive, block.timestamp);
    }

    // cancelOrder
    function cancelOrder(uint256 _id) public {
        _Order memory myorder = orders[_id];
        require(myorder.id == _id);
        orderCancel[_id] = true;

        emit Cancel(myorder.id, msg.sender, myorder.tokenGet, myorder.amountGet, myorder.tokenGive, myorder.amountGive, block.timestamp);
    }

    // fillOrder




}
