pragma solidity >=0.6.0 <0.7.0;

import "./Ownable.sol";
import "./Project.sol";

contract ProjectManager is Ownable {

	struct StructProject {
		Project _project;
		string _identifier;
	}

	mapping(string => StructProject) public projects;

	function createProject (string memory _identifier, uint _amountNeeded) public onlyOwner {
		Project project = new Project(this, _identifier, _amountNeeded);
		projects[_identifier]._project = project;
		projects[_identifier]._identifier = _identifier;
	}

	function fundProject (string _identifier) public payable {
		Project project = projects[_identifier]._project;
		require(!project.isFunded, 'Project is already funded')
		require(project.amountReceived + msg.value < project.amounNeeded, 'You sent too much money')
	}
}