// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GameItem is ERC721 {
    constructor() ERC721("token2", "TK2") {}
   
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    /// our structture that hold data 
    struct Item {
       string title;
       string url;
    }

    /// map to access 
    mapping(uint256 => Item) private _items;
    
    /// Limit of tokens
    uint256 private constant MAX_ITEMS = 1000;

    /// Price per token
    uint256 private constant TOKEN_PRICE = 0.001 ether;

    /// buy (mint) new postion 
    function buyItem(string memory title, string memory image) public payable {
        require(_tokenIds.current() < MAX_ITEMS, "Maximum number of items reached");
        require(msg.value >= TOKEN_PRICE, "Insufficient funds");
        
        // Increment the token ID
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        
        // Mint the new token and assign it to the sender
        _mint(msg.sender, newItemId);
        
        // Set the item information
        _items[newItemId] = Item(title, image);
        
        // Transfer any excess funds back to the sender
        if (msg.value > TOKEN_PRICE) {
            payable(msg.sender).transfer(msg.value - TOKEN_PRICE);
        }
    }



    /// getter
    function getItem(uint256 tokenId) public view returns (string memory, string memory) {
        require(_exists(tokenId), "Item does not exist");
        
        Item memory item = _items[tokenId];
        return (item.title, item.url);
    }
    
    /// modify item (owner only)
    function modifyItem(uint256 tokenId, string memory newTitle, string memory newUrl) public {
        require(_exists(tokenId), "Item does not exist");
        require(ownerOf(tokenId) == msg.sender, "You are not the owner of this item");
        
        /// Update the item information
        _items[tokenId].title = newTitle;
        _items[tokenId].url = newUrl;
    }
    
    /// transfer item to other person (owner only)
    function transferItem(uint256 tokenId, address to) public {
        require(_exists(tokenId), "Item does not exist");
        require(ownerOf(tokenId) == msg.sender, "You are not the owner of this item");
        
        /// Transfer the item to the new owner
        _transfer(msg.sender, to, tokenId);
    }
}
