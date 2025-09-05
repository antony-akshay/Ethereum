// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation{
    string[] public  candidateNames;
    mapping(string => uint256) voteCount;

    function addCandidates(string memory _name) public {
        candidateNames.push(_name);
        voteCount[_name] = 0;
    }

    function vote(string memory _name) public {
        voteCount[_name]  ++;
    }

    function getNames() public view returns(string[] memory){
        return candidateNames;
    }

    function getVotes(string memory _name) public view  returns(uint256){
        return (voteCount[_name]);
    }
}

