pragma solidity ^0.5.0;

// lvl 3: equity plan
contract DeferredEquityPlan {
    uint fakenow=now;
    address human_resources;
    address payable employee;               // bob, the employee
    bool active = true;                     // this employee is active at the start of the contract
    uint total_shares = 1000;               // total shares to be distributed to bob over time
    uint annual_distribution = 250;         // number of shares biob gets each year
    uint start_time = fakenow;                  // permanently store the time this contract was initialized
    uint unlock_time = fakenow + 365 days;      // unlock shares 365 days from contract start
    uint public distributed_shares;         // starts at 0

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");                        //contract must be active
        require(unlock_time <= fakenow, "You are not yet vested!");                 // ensure the time has been vested
        require(distributed_shares < total_shares, "Not enough shares!");       //ensure distributed shares is less than total
        unlock_time += 365 days;                                                // must wait another year after distribution
        distributed_shares = (fakenow - start_time) /365 * 250;                     //calculate how many shares have been distributed since start of contract

        // double check in case the employee does not cash out until after 5+ years
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    function fastforward() public {
        fakenow += 100 days;
    }


    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}
