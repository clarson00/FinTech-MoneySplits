pragma solidity ^0.5.0;

// lvl 1: equal split
contract AssociateProfitSplitter {
    // @TODO: Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`.
    
    address payable employee_one;
    address payable employee_two ;
    address payable employee_three;
    address payable owner = msg.sender;

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        require(msg.sender == owner, "You do not own this account");
           
        
        
        uint amount = msg.value / 3; // Split the value between the 3 employees 
        uint balance_amount = msg.value - amount * 3;

        // @TODO: Transfer the amount to each employee
        // Your code here!
        address(employee_one).transfer(amount);
        address(employee_two).transfer(amount);
        address(employee_three).transfer(amount);

        // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
        // Your code here!
        msg.sender.transfer(balance_amount);
        
        
    }

    function() external payable {
        // @TODO: Enforce that the `deposit` function is called in the fallback function!
        // Your code here!
        deposit();
        
        
    }
}
