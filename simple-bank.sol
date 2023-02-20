//SPDX-License-Identifier: GPL-3.0
pragma solidity = 0.8.17;

import "@openzeppelin/contracts/access/ownable.sol";

contract SimpleBank is Ownable {
    
    uint public sum;
    uint public balance;
    bool public currentBankState;
    address [] public members;
    
    function addToBalance() public payable {
        require(currentBankState && rest() != 0 && arrayCheck(msg.sender) && msg.value <= rest());
        balance += msg.value; 
    }

    function start(uint _sum) public onlyOwner returns(bool) {
        sum = _sum;
        members.push(owner());
        currentBankState = true;
        return currentBankState;
    }

    function addMember(address _address) public onlyOwner {
        members.push(_address);
    }

    function withdraw() public onlyOwner {
        require(rest() == 0);
        currentBankState = false;
        members = new address [](0);
        payable(owner()).transfer(address(this).balance);
    }

    ///@dev checking if address belongs to array
    function arrayCheck (address _address) private view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (_address == members[i]) {
                return true;
            }
        }
        return false;
    }

    function rest () public view returns(uint) {
        uint _rest = sum - balance;
        return _rest;
    }

    function viewBalance() public view returns (uint) {
        return balance;
    }

    function viewMembers() public view returns (address[] memory) {
        return members;
    }

    function viewSum() public view returns(uint) {
        return sum;
    }

    function viewCurrentBankState() public view returns(bool) {
        return currentBankState;
    }


}