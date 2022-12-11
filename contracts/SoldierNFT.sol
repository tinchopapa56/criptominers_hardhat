// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SoldierNFT is Ownable, ERC721URIStorage{
    
    uint256 price;
    uint256 public tokenCount; //funca tmbien como token id
    
    struct Soldier {
        uint256 uuid;
        string name;
        uint256 power;
        uint8 rarity;
        address owner;
    }

    mapping (uint256 => Soldier) soldiers;
    // Soldier[] soldiers;

    event SoldierCreated(
        uint256 uuid,
        string name,
        uint256 power,
        uint8 rarity,
        address owner
    );

    constructor() ERC721("Soldier", "SLD"){
        price = 0.0002 ether;
    }

    // function mint(string memory _tokenURI) public payable returns(uint256) {
    function mint(string memory _tokenURI) external returns(uint256) {
        // require(msg.value >= price, "No te alcanza papa, minimo es 0.0002");
        //COMPLETARLOS CON ORACULO
        soldiers[tokenCount] = Soldier(tokenCount, "Dustin hoffman", 146, 3, owner());       //COMPLETALOS: con oraculo
        tokenCount++;
        _safeMint(msg.sender, tokenCount);
        _setTokenURI(tokenCount, _tokenURI);
        // emit SoldierCreated(tokenCount, "name", power, rarity, owner);
        return tokenCount;
    }
    function getPrice() public view returns(uint256){
        return price;
    }
    function getMyNfts() public view returns (uint256[] memory _misTokens) {
            _misTokens = new uint256[](balanceOf(msg.sender));
            uint256 currentIndex;
            for (uint256 i = 0; i < tokenCount ; i++){
                if(ownerOf(i+1) == msg.sender) {
                    _misTokens[currentIndex] = i + 1;
                    currentIndex++;
                }
            }

        }
   
    // function withdraw() public {
    //     require(msg.sender == owner());
    //     address _owner = owner();
    //     uint256 amount = address(this).balance;
    //     (bool sent, ) =  _owner.call{value: amount}("");
    //     require(sent, "Failed to send Ether");
    //     }
    function getMyStructs() public view returns(Soldier[] memory _myStructs) {
            uint256 tokensOwned = balanceOf(msg.sender);
            _myStructs = new Soldier[](tokensOwned);
            uint256 currentIndex;
            for (uint256 i = 0; i < tokenCount ; i++){
                if(ownerOf(i+1) == msg.sender) {
                    _myStructs[currentIndex] = soldiers[i+1];
                    currentIndex++;
                    if(_myStructs.length == tokensOwned) return _myStructs;
                } else {
                    currentIndex++;
                }
            }
            return _myStructs;
    }

    receive() external payable {}   // Function to receive Ether. msg.data must be empty
    fallback() external payable {}  // Fallback function is called when msg.data is not empty

}

// function newWoldierWeb3() external payable {
    //     address owner = owner();

    // }
    // function mintWithEternal() public payable{
    //     //mint function for your nft that in order for mint take some amount of tokens from the user
    //         //podria hacer instance de ETERNAL mio
    //         //ahi agarrar el balanceOf
    //         // require(balaceOf >= price, "no te alcanzan los eternal papa")
    //         // burneternal(price)
    //         // y AHI LA FUNCION "normal" de MINT
    //     //
    // }

    // struct Soldier{
    //     uint256 uuid;
    //     string name;
    //     uint256 power;
    //     uint8 rarity;
    //     address owner;
    // }
    // function newSoldierWeb2(string memory name, uint256 uuid, uint256 power, uint8 rarity) external cost(msg.value) payable{
    //     address _owner = owner();
    //     //setee mi soldier
    //     Soldier memory currentSoldier;
    //         currentSoldier.name = name;
    //         currentSoldier.uuid = uuid;
    //         currentSoldier.power = power;
    //         currentSoldier.rarity = rarity;
    //         currentSoldier.owner = _owner;
    //     tokenCount += 1;
    //     // soldierNFTIds[msg.sender] = currentSoldier.uuid;
    //     // allSoldiers.push(currentSoldier);
    //     _safeMint(msg.sender, tokenCount);
    // }