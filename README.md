## Trias IEO 

​	The contract based on ERC20.

##### The contract:

    The init params：

~~~json
 uint256 public totalSupply  
 string public name  
 string public symbol   
 uint public decimals    
~~~

##### main methods：

transfer(address _to, uint256 _value)：Send `_value` tokens to `_to` from `msg.sender`

transferFrom(address _from, address _to, uint256 _value): Send `_value` tokens to `_to` from `_from` on the condition it is approved by `_from`

approve(address _spender, uint256 _value): `msg.sender` approves `_spender` to spend `_value` tokens on its behalf. This is a modified version of the ERC20 approve function to be a little bit safer

balanceOf(address _owner)：_owner The address that's balance is being requested

allowance(address _owner, address _spender)：This function makes it easy to read the `allowed[]` map
