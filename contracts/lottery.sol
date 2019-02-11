pragma solidity ^0.4.25;

contract Lottery{
    address public manager;
    address[] public players;
    
    constructor() public{
        manager = msg.sender;
    }
    
    function joinLoterry() public payable {
        require(msg.value > 1 ether, "need more than one ether");
        players.push(msg.sender);
    }
    
    function random() private view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }
    function pickWinner() public{
        require(manager == msg.sender, "need manager");
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address[](0);
    }
    
}