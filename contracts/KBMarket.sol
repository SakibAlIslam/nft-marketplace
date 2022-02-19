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

    mapping(uint256 => MarketToken) private idToMarketToken;

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

    // two functions to interact with the contract
    // create a market item to put it up for sale
    // create a market sale for buying and selling between parties

    function mintMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
        // non reentrant is a modifier to prevent reentry attack of multiple request
        require(price > 0, "Price must be greater than zero");
        require(
            msg.value == listingPrice,
            "Price must be equal to listingPrice"
        );

        _tokenIds.increment();
        uint256 itemId = _tokenIds.current();

        //putting it up for sale - bool - no owner
        idToMarketToken[itemId] = MarketToken(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );

        //NFT transaction
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);

        emit MarketTokenMinted(
            itemId,
            nftContract,
            tokenId,
            msg.sender,
            address(0),
            price,
            false
        );
    }

    //function to conduct transactions and market sales

    function createMarketSale(address nftContract, uint256 itemId)
        public
        payable
        nonReentrant
    {
        uint256 price = idToMarketToken[itemId].price;
        uint256 tokenId = idToMarketToken[itemId].tokenId;
        require(
            msg.value == price,
            "Please submit the asking price in order to continue"
        );

        //transfer the amount to the selller
        idToMarketToken[itemId].seller.transfer(msg.value);
        //transfer the toke from contract address to the buyer
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        idToMarketToken[itemId].owner = payable(msg.sender);
        idToMarketToken[itemId].sold = true;
        _tokensSold.increment();

        payable(owner).transfer(listingPrice);
    }

    //functions to fetchMarketItems - minting, buyings and sellings
    // return the number of sold items

    function fetchMarketTokens() public view returns(MarketToken[] memory) {
        uint itemCount = _tokenIds.current();
        uint unsoldItemCount = _tokenIds.current() - _tokensSold.current();
        uint currentIndex = 0;

        //looping over the number of items created (if number has not been sold populate the array)
        MarketToken[] memory items = new MarketToken[](unsoldItemCount);
    }
}
