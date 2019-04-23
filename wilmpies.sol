pragma solidity >=0.4.22 <0.6.0;
contract Wilmpies {

    uint totalAmound = 0;
    uint maxAmount;
    address creator;

    mapping(address => uint) Wilmpers;

    constructor(uint max)public{
        maxAmount =max;
        creator = msg.sender;
    }

    modifier __isTotalAmountExceeded() {
        require( totalAmound <= maxAmount, "total money is spend");
        _;
    }

    modifier __isCreator() {
        require( creator == msg.sender,  "you are not the creator");
        _;
    }

    function setAmount (address buyer, uint amount) public __isTotalAmountExceeded __isCreator{
        Wilmpers[buyer] += amount;
        totalAmound += amount;
    }

    function transfer (address buyer, address seller, uint amount) public {
        require(Wilmpers[seller]> amount, "seller doesn't have enough money.");
        Wilmpers[seller] -= amount;
        Wilmpers[buyer] += amount;
    }

    function get_my_amount() public view returns(uint){
        return Wilmpers[msg.sender];
    }

    function unused_wilmpies() public view returns(uint){
        return maxAmount - totalAmound;
    }
}
