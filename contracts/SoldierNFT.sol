// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoldierNFT is ERC721, Ownable{
    
    uint256 price;
    uint256 public tokenCount; //funca tmbien como token id
    mapping(uint256 =>string) private _tokenURIs;   //tokenid => tokenuri
    mapping(address => uint256) internal _balances; //uantos NFTS tiene
    mapping(uint256 => address) internal _owners;   
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

    constructor() ERC721("Soldier", "SLD"){
        price = 0.0001 ether;
    }
    modifier cost (uint256 _price){
        require(_price == price);
        _;
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {    //  sobrescribe deafult ERC721 implementation ("")
        require(ownerOf(tokenId) != address(0), "token doesnt exist");
        return _tokenURIs[tokenId];
    }
    
    function wachinMint(string memory _tokenURI) public {
        tokenCount += 1;
        _balances[msg.sender] += 1;  // balanceOf(msg.sender) += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
        //event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
        // cuantosNFTTiene = balanceOf(msg.sender);
        
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

    
    
    

    function withdraw() public {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
    receive() external payable {}   // Function to receive Ether. msg.data must be empty
    fallback() external payable {}  // Fallback function is called when msg.data is not empty

}