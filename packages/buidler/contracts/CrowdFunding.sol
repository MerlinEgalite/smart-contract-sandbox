// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.8.0;


// Structs can be defined outside contract to be used in other contracts
struct Funder {
    address addr;
    uint amount;
}

contract CrowdFunding {

    struct Campaign {
        address payable beneficiary;
        uint fundingGoal;
        uint numFunders;
        uint amount;
        mapping (uint => Funder) funders;
    }

    uint numCampaigns;
    mapping (uint => Campaign) campaigns;

    function newCampaign(address payable beneficiary, uint goal) public returns (uint campaignID) {
        campaignID = numCampaigns++;
        Campaign storage campaign = campaigns[campaignID];
        campaign.beneficiary = beneficiary;
        campaign.fundingGoal = goal;
    }

    function contribute(uint campaignID) public payable {
        Campaign storage campaign = campaigns[campaignID];
        require(!checkGoalReached(campaignID), 'The campaign is already funded');
        require(campaign.amount + msg.value <= campaign.fundingGoal, 'You put too much money!');
        campaign.funders[campaign.numFunders++] = Funder(msg.sender, msg.value);
        campaign.amount += msg.value;
    }

    function receiveFunds(uint campaignID) public returns (bool reached) {
        Campaign storage campaign = campaigns[campaignID];
        require(msg.sender == campaign.beneficiary, 'You are not the owner');
        if (!checkGoalReached(campaignID))
            return false;
        uint amount = campaign.amount;
        campaign.amount = 0;
        campaign.beneficiary.transfer(amount);
    }

    function checkGoalReached(uint campaignID) public view returns (bool reached) {
        Campaign storage campaign = campaigns[campaignID];
        if (campaign.amount < campaign.fundingGoal)
            return false;
        return true;
    }
}