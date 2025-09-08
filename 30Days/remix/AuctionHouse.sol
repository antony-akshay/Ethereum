// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse{
    address public owner;
    string public item;
    uint256 public auctionEndTime;
    address private highestBidder;
    uint256 public  highestBid;
    bool public ended;

    mapping (address => uint256) public bids;
    address[] public bidders;

    constructor(string memory _item,uint256 _biddingTime){
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid(uint256 amount) external {
        require(block.timestamp < auctionEndTime, "Auction has already ended");
        require(amount > 0 ,"bid amount must be greater than zero");
        require(amount > bids[msg.sender] , "bid must be higher than your previouse sender");

        if(bids[msg.sender] == 0){
            bidders.push(msg.sender);
        }

        bids[msg.sender] = amount;

        if(amount > highestBid){
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    function endAuction() external {
        require(block.timestamp >= auctionEndTime,"auction has not ended yet");
        require(!ended,"auction ended already been called");
        ended = true;

    }


    function getResult()external view returns(address,uint256){
        require(ended,"auction hasn't ended yet");
        return (highestBidder,highestBid);
    }

    function getAllBidders() external  view returns(address[] memory){
        return bidders;
    }
}
