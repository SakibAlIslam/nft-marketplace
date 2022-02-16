//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//we will bring in the openzeppelin ERC721 NFT functionality

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

//security against transactions for multiple requests
import "hardhat/console.sol";

contract KBMarket is ReentrancyGuard {
    using Counters for Counters.Counter;

    //number of items minting , number of transactions, tokens that have not been sold
    //keep track of tokens total number - tokenId
    //arrays need to know the length - help to keep track of arrays

    Counters.Counter private _tokenIds;
    Counters.Counter private _tokensSold;

    //determine who is the owner of the contract
    //charge a listing fee so the owner makes a commission
    address payable owner;
    //we are deploying to matic the API is same so you can use ether the same as matic
    // they both have 18 decimal
    // 0.045 is the cents
    uint256 listingPrice = 0.045 ether;

    constructor() {
        //set the owner
        owner = payable(msg.sender);
    }

    // structs can act like objects

    struct MarketToken {
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    //tokenId return which marketToken - fetch which one it is

    mapping(uint256 => MarketToken) private idToTokenItem;

    // listen to events from the client
    event MarketTokenMinted(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    // get the listing price 
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }
    
}
