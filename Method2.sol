// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";

contract CryptoBank is ReentrancyGuard {
    using Address for address payable;

    // keeps track of all savings account balances
    mapping(address => uint) public balances;

    // deposit funds into the sender's account
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // withdraw all funds from the user's account
    function withdraw() external {
        require(balances[msg.sender] > 0, "Withdrawl amount exceeds available balance.");
        
        
        console.log("CryptoBank balance: ", address(this).balance);
        console.log("Attacker balance: ", balances[msg.sender]);
        
        
       
        uint accountBalance = balances[msg.sender]
        balances[msg.sender] = 0;
        payable(msg.sender).sendValue(balances[msg.sender]);
        
    }

    // check the total balance of the CryptoBank contract
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
