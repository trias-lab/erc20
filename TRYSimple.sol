pragma solidity ^0.4.24;
/**
 * Math operations with safety checks
 */
contract SafeMath {
    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function safeSub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function safeAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
}

/**
 * TRY Token by Trias
 * As ERC20 standard
 */
contract TRY is SafeMath{  
    uint256 public totalSupply;
    string public name;
    string public symbol;
    uint8 public decimals;
    // token总量，默认会为public变量生成一个getter函数接口，名称为totalSupply().
    // 构造函数  初始化合约时使用
    constructor(uint256 _initialAmount,string _tokenName,uint8 _decimalUnits,string _tokenSymbol) public {
        //decimals = _decimalUnits;
        //balances[msg.sender] = _initialAmount * 10 ** uint256(decimals);
        balances[msg.sender] = _initialAmount; // 由于没有直接乘以10的18次方，所以，最后初始化Token，也就是发币的时候，需要在最后面加上18个0，来表示是多少wei个单位
        totalSupply = _initialAmount;
        name = _tokenName;
        decimals = _decimalUnits;
        symbol = _tokenSymbol;
    }
    
    mapping(address => uint256) balances; //查询余额的映射
    mapping(address => mapping(address => uint256)) public allowance; //授权映射

    //发生转账时必须要触发的事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    //当函数approve(address _spender, uint256 _value)成功执行时必须触发的事件
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    // event Approval(address _owner,address _spender,uint256 _value);

    /// 获取账户_owner拥有token的数量
    function balanceOf(address _owner) public constant returns (uint256 balance) {//constant==view
        return balances[_owner];
    }

    /**
     * Send coins
     * owner 使用这个进行发送代币
     */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != 0x0, 'cannot transfer to the zero address');
        //默认totalSupply 不会超过最大值 (2^256 - 1).
        require(balances[msg.sender] >= _value);
        balances[msg.sender] = safeSub(balances[msg.sender], _value);
        //从消息发送者账户中减去token数量_value
        balances[_to] = safeAdd(balances[_to], _value);
        //往接收账户增加token数量_value
        emit Transfer(msg.sender, _to, _value);
        //触发转币交易事件
        return true;
    }

    /**
     * A contract attempts to get the coins
     * 从账户_from中往账户_to转数量为_value的token，与approve方法配合使用
     * token的所有者用来发送token
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(_to != 0x0, 'cannot transfer to the zero address');
        require(_value > 0);
        require(balances[_from] >= _value && allowance[_from][msg.sender] >= _value);
        
        balances[_to] = safeAdd(balances[_to], _value);
        //接收账户增加token数量_value
        balances[_from] = safeSub(balances[_from], _value);
        //支出账户_from减去token数量_value
        allowance[_from][msg.sender] = safeSub(allowance[_from][msg.sender], _value);
        //消息发送者可以从账户_from中转出的数量减少_value
        emit Transfer(_from, _to, _value);
        //触发转币交易事件
        return true;
    }

    /**
     * Allow another contract to spend some tokens in your behalf
     * 消息发送账户设置账户_spender能从发送账户中转出数量为_value的token
     */
    function approve(address _spender, uint256 _value) public returns (bool success){
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * 获取账户_spender可以从账户_owner中转出token的数量
     * 控制代币的交易，如可交易账号及资产, 控制Token的流通
     */
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining){
        return allowance[_owner][_spender];
    }
    
}
