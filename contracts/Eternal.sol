// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Eternal is ERC20, Ownable {
    uint256 eternalPrice = 0.00001 ether;
    uint256 maxSupply = 5000000 * 10**18; //5million tokens
    mapping(address => bool) public walletsClaimed1k;

    constructor(uint256 initialSupply) ERC20("Eternal", "ETR"){
        _mint(msg.sender, initialSupply);
    }

    function mint(uint256 amount) public payable {
        uint256 _costOfPurchase = amount * eternalPrice;
        require(msg.value >= _costOfPurchase, "you do not have enough eth for the tx");
        uint256 amountToCheck = amount * 10 **18;
        require( (totalSupply() + amountToCheck) < maxSupply, "exceeds max supply of tokens");
        _mint(msg.sender, amountToCheck);
    }
    //cada wallet pueda mintear 1.000 gratis
    function claimFree1k() public payable {
        address _owner = owner();
        uint256 freeAmount;
        require(!walletsClaimed1k[msg.sender], "already claimed your free 10k");
        if(msg.sender == _owner){
            // freeAmount = 10000 * 10**18;
            freeAmount = 10000;
        } else {
            // freeAmount = 1000 * 10**18;
            freeAmount = 1000;
        }
        
        walletsClaimed1k[msg.sender] = true;
        _mint(msg.sender, freeAmount);
    }



    // function totalSupply() public view returns (uint256){}
    // function balanceOf(address _owner) public view returns(uint256){}
    // function transfer(address to, uint256 amount){}
    // function approve(spender, amount){}
    // function transferFrom(address from, address to, uint256 amount){}
    
}