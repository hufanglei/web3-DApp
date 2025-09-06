pragma solidity >= 0.4.16 < 0.9.0;


contract Exchange {

    // 收费账户地址
    address public feeAccount;
    // 费率百分比
    uint256 public feePercent;

    // 构造函数
    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }

    mapping(address => mapping(address => uint256)) public tokens;
    mapping(address => mapping(address => mapping(uint256 => uint256))) public orders;
    mapping(address => mapping(address => uint256)) public orderCount;
    mapping(address => mapping(address => uint256)) public filledOrders;
    mapping(address => mapping(address => uint256)) public cancelledOrders;

    event OrderCreated(address indexed user, address indexed tokenGet, uint256 amountGet, address indexed tokenGive, uint256 amountGive, uint256 expires, uint256 nonce, address indexed user);


}