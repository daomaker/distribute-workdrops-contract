pragma solidity ^0.6.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./StandardToken.sol";

contract SMDistribute {
    
    using SafeMath for uint;
    
    function tokenSendMultiple(address _tokenAddress, address payable[] memory _to, uint[] memory _value)  internal  {

	     require(_to.length == _value.length);
	     require(_to.length <= 255);

             StandardToken token = StandardToken(_tokenAddress);
        
	     for (uint8 i = 0; i < _to.length; i++) {
	     	token.transferFrom(msg.sender, _to[i], _value[i]);
	     }
	}
	
    function ethSendMultiple(address payable[] memory _to, uint[] memory _value) internal {

	    uint remainingValue = msg.value;

	    require(_to.length == _value.length);
	    require(_to.length <= 255);

            for (uint8 i = 0; i < _to.length; i++) {
		remainingValue = remainingValue.sub(_value[i]);
		require(_to[i].send(_value[i]));
	    }
    }
    
    function distributeToken(address _tokenAddress, address payable[] memory _to, uint[] memory _value) payable public {
	    tokenSendMultiple(_tokenAddress, _to, _value);
    }
    
    function distributeEther(address payable[] memory _to, uint[] memory _value) payable public {
		 ethSendMultiple(_to,_value);
	}
}
