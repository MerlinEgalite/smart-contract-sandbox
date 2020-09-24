pragma solidity >=0.6.0 <0.7.0;

contract Project {

	struct Project {
		string identifier;
		bool isFunded;
		address owner;
		uint amountNeeded;
		uint amountReceived;
	}

	constructor (string identifier, uint _amountNeeded) public {
		identifier = _identifier;
		fundraising = false;
		owner = msg.sender;
		amountNeeded = _amountNeeded;
		amountReceived = 0;
	}

	function receive () external payable {
		require(!isFunded, 'Project is already funded')
		// SafeMath
		require(amountReceived + msg.value < amounNeeded, 'You sent too much money')
		amountReceived += msg.value;
	}

	fallback () external { }
}