// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.5.0;
pragma experimental ABIEncoderV2;

contract RollercoinAuction {
    struct Item {
        address  owner;
        string   name;
        uint256  price;
    }
    mapping (string => Item) items;
    string[] public names;
    
    constructor() public {
        setItem("AAA", msg.sender, 1 ether / 1000);
        setItem("BBB", msg.sender, 1 ether / 1000);
        setItem("CCC", msg.sender, 1 ether / 1000);
        setItem("DDD", msg.sender, 1 ether / 1000);
        setItem("EEE", msg.sender, 1 ether / 1000);
    }
    
    function setItem(string memory _name, address _owner, uint256 _price) private {
        Item storage i = items[_name];
        i.owner = _owner;
        i.name = _name;
        i.price = _price;
        items[_name] = i;
        
        names.push(_name) -1;
    }
    
    function getItem(string _name) view public returns (string, address, uint256) {
        return (items[_name].name, items[_name].owner, items[_name].price);
    }
    
    function getItems() view public returns (string[] memory) {
        return names;
    }
    
    function buyItem(string _name) payable {
        var _item = items[_name];
        uint256 nextPrice = _item.price + (_item.price / 2);
        require(msg.value >= nextPrice);
        _item.owner = msg.sender;
        _item.price = msg.value;
        items[_name] = _item;
    }
}