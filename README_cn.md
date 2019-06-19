## Trias ICO

​	这个项目的主要目的是发行Trias基于ERC20的代币。

##### 代币合约:

合约的参数包含：

~~~json
 uint256 public totalSupply;  //代币总量
 string public name;   //代币名称
 string public symbol;   //代币符号
 uint public decimals;    //小数点位数
~~~

##### 主要方法：

transfer(address _to, uint256 _value)：使用这个进行发送代币

transferFrom(address _from, address _to, uint256 _value): 从账户_from中往账户_to转数量为_value的token，与approve方法配合使用

approve(address _spender, uint256 _value): 消息发送账户设置账户_spender能从发送账户中转出数量为_value的token

balanceOf(address _owner)：获取账户_owner拥有token的数量

allowance(address _owner, address _spender)：获取账户_spender可以从账户_owner中转出token的数量

##### 可提选择的方法：

Burn(address indexed from, uint256 value): “燃烧”掉指定数量的token

Freeze(address indexed from, uint256 value)： 冻结调用者地址对应的指定数量的token 	

Unfreeze(address indexed from, uint256 value): 解冻调用者地址对应的指定数量的token