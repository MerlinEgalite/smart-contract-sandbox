pragma solidity >=0.6.0 <0.7.0;

import "@nomiclabs/buidler/console.sol";

contract Lending {

	struct Payment {
		uint amount;
		uint timestamp;
	}

	mapping(address => uint) public Projects;

}