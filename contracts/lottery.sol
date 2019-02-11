pragma solidity ^0.4.25;

contract Lottery{
    address public manager;
    address[] public players;
    
    constructor() public{
        manager = msg.sender;
    }
    
    //join lottery by sending more than 1 ether
    function joinLoterry() public payable {
        require(msg.value > 1 ether, "need more than one ether");
        players.push(msg.sender);
    }
    
    //random function utilizes keccak256 algorithm
    function random() private view returns(uint){

        return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }

    //picking a winner, only manager can pick
    function pickWinner() public restricted{
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address[](0);
    }

    //makes sure the sender is the manager
    modifier restricted() {
        require(msg.sender == manager, "need a manager");
        _;
    }

    //get all players that joined lottery
    function getPlayers() public view returns(address[]){
        return players;
    }
}