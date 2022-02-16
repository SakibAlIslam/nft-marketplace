//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//we will bring in the openzeppelin ERC721 NFT functionality

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import '@openzeppelin/contracts/utils/Counters.sol';

//security against transactions for multiple requests
import 'hardhat/console.sol';

contract KBMarket is ReentrancyGuard {
    using Counters for Counters.Counter;

    //number of items minting , number of transactions, tokens that have not been sold 
    //keep track of tokens total number - tokenId
    //arrays need to know the length - help to keep track of arrays

    Counters.Counter private _tokenIds ;
    Counters.Counter private _tokensSold;

    //determine who is the owner of the contract
    //charge a listing fee so the owner makes a commission
    
}