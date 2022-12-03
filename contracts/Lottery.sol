pragma solidity ^0.4.17;

contract Lottery{

    address public manager;

    address[] public participants;

    function Lottery() public{
        manager = msg.sender;
    }

    function addParticipant() public payable{
        require(msg.value > 0.01 ether);
        participants.push(msg.sender);
    }

    function getRandom() private view returns(uint){
        return uint(keccak256(block.difficulty,block.timestamp,participants));
    }

    function chooseWinner() public{
        require(msg.sender == manager);
        uint index = getRandom()%participants.length;
        participants[index].transfer(this.balance);
        participants = new address[](0);
    }

    function getAllParticipants() public view returns(address[]){
        return participants;
    }
}