// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{
    uint32 public count;

    function increment() public{
        count++;
    }

    function decrement() public{
        if(count == 0){
            return;
        }
        count--;
    }

}
