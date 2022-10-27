// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.4;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract CryptoDevs is ERC721Enumerable, Ownable {


//     string _baseTokenURI;
//     uint256 public _price = 0.01 ether;
//     uint256 public tokenIds;


//     constructor (string memory baseURI, address whitelistContract) ERC721("Crypto Devs", "CD") {
//         _baseTokenURI = baseURI;
//         // whitelist = IWhitelist(whitelistContract);
//     }



//     function mint() public payable {
//         require(tokenIds < maxTokenIds, "Exceed maximum Crypto Devs supply");
//         require(msg.value >= _price, "Ether sent is not correct");
//         tokenIds += 1;
//         _safeMint(msg.sender, tokenIds);
//     }

//     /**
//     * @dev _baseURI overides the Openzeppelin's ERC721 implementation which by default
//     * returned an empty string for the baseURI
//     */
//     function _baseURI() internal view virtual override returns (string memory) {
//         return _baseTokenURI;
//     }
// }