// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage{

      using Strings for uint256;
      using Counters for Counters.Counter;
      Counters.Counter private _tokenIds;
     
      mapping(uint256=>uint256) public tokenIdtoLevels;

      constructor() ERC721("Chain Battles","CHBTLS"){

      }
       function generateCharacter(uint256 tokenId) public view returns(string memory){
       //It's concatanate strings to create nft
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',"Warrior",'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Level: ",getLevels(tokenId),'</text>',
            '</svg>'
        );
        //This will create the svg dynamicly with base34 encoder...
        return string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(svg)
            ));

        }
        //getLevels takes tokenId and returns the levels as string format
        function getLevels(uint256 tokenId) public view returns (string memory) {
            uint256 levels = tokenIdtoLevels[tokenId];
             return levels.toString();
        }

        function getTokenURI(uint256 tokenId) public view returns (string memory){
        //As below you can see that its just concatanate the strings to create json object 
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "Chain Battles #', tokenId.toString(), '",',
                '"description": "Conan the Barbarian on chain",',
                '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    function mint() public {
        //increase token id so token id start from 1 
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        //newItemId will start from level 0 
        tokenIdtoLevels[newItemId] = 0;
        // _setTokenURI function came from ERC721URIStorage contract...
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId));
        require(ownerOf(tokenId) == msg.sender, "You must own this NFT to train it!");
        uint256 currentLevel = tokenIdtoLevels[tokenId];
        tokenIdtoLevels[tokenId] = currentLevel + 1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}