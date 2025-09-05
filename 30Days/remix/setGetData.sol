// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract getSetName{
    string name;
    string hobby;

    function setdata(string memory _name, string memory _hobby)public returns(string memory ,string memory){
        name = _name;
        hobby = _hobby;
        return(name,hobby);
    }

}
