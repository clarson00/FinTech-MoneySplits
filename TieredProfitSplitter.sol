pragma solidity ^0.5.0;

// lvl 2: tiered split
contract TieredProfitSplitter {
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        
        amount = points * 60;   // Pay CEO 60%
        total += amount;             // track total for remainders
        employee_one.transfer(amount);  // transfer to employee
        
        
        amount = points * 25;   // Pay CTO 25%
        total += amount;          // track total for remainders
        employee_two.transfer(amount);  // transfer to employee

        amount = points * 15;   // Pay investor bob 25%
        total += amount;             // track total for remainders
        employee_three.transfer(amount);  // transfer to bob
        
        
        employee_one.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}