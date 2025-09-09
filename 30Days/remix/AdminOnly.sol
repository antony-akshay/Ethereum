// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly{
    address public owner;
    uint256 public treasureAmount;
    mapping (address=>uint256) public withdrawalAllowance;
    mapping (address=>bool) public hasWithdrawn;
    constructor() {
        owner = msg.sender;
    }

    // runs before each function call
    modifier OnlyOwner(){
        require(msg.sender == owner,"Access denied:Only the owner can perform this action");_;
    }

    function addTreasure(uint256 amount) public OnlyOwner{
        treasureAmount += amount;
    }

    function approveWithdrawal(address recipient,uint256 amount) public OnlyOwner{
        require(amount <= treasureAmount, "Insufficient funds in the contract");
        withdrawalAllowance[recipient] = amount;
    }

    function withdrawTreasure(uint256 amount) public{
        if(msg.sender == owner){
            require(amount <= treasureAmount,"Insufficient funds in the contract");
            treasureAmount-=amount;
            return;
        }

        uint256 allowance = withdrawalAllowance[msg.sender];

        require(amount <= allowance ,"Nah! you don't have that much in you");

        require(allowance > 0,"You do not have any treasure allowance");

        require(!hasWithdrawn[msg.sender],"You have already withdrawn your treasure");

        require(allowance <= treasureAmount,"not enough treasure in chest");

        hasWithdrawn[msg.sender] = true;
        treasureAmount -= amount;
        withdrawalAllowance[msg.sender] = 0;
    }

    function resetWithdrawalStatus(address user) public OnlyOwner{
        hasWithdrawn[user]  = false;
    }

    function transferOwnership(address newOwner) public OnlyOwner{
        require(newOwner != address(0),"Invalid new Owner");
        owner = newOwner;
    }

    function getTreasureDetail() public view OnlyOwner returns(uint256){
         return treasureAmount;
    }
}
