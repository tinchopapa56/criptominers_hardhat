const { expect } = require("chai")
const {ethers} = require("hardhat")

//equal es mas estricto que eql

describe("SoldierNFT", () =>{
    let soldierNFT;
    let deployer, user1, user2, users;
    let testURI = "testURI"
    // let postHash= "testhash"
    beforeEach(async ()=>{
        [deployer, user1, user2, ...users] = await ethers.getSigners();
        const soldierNFTContractFactory = await ethers.getContractFactory("SoldierNFT");
        soldierNFT = await soldierNFTContractFactory.deploy();
            await soldierNFT.connect(user1).mint(testURI)
            await soldierNFT.connect(user2).mint(testURI)
            await soldierNFT.connect(user1).mint(testURI)
    })
    describe("deployment", async()=>{
        it("tracks name & symbol", async() => {
            expect(await soldierNFT.name()).to.equal("Soldier");
            expect(await soldierNFT.symbol()).to.equal("SLD");
        })
        it("tracks price", async() => {
            const BIG = await soldierNFT.getPrice();
            // const small = parseInt(BIG.toString());
            const small = ethers.utils.formatEther( BIG )
            expect(small).to.equal("0.0002");
        })
        // it("tracks initial supply", async()=>{
        //     expect(await soldierNFT.totalSupply()).to.equal(100)
        // })
    })
    describe("functions", async()=>{
        it("mint 2x: user1 & user2", async()=>{
            const user1Address = await user1.getAddress();
            const user2Address = await user2.getAddress();
            // await soldierNFT.connect(user1).mint(testURI, {value: "2 ether"})
            //ACORDATE QUE ARRIBA HAY 3 minteos!!!!!!!!
            expect(await soldierNFT.tokenCount()).to.equal(3);
            expect(await soldierNFT.balanceOf(user1Address)).to.equal(2);
            expect(await soldierNFT.ownerOf(2)).to.equal(user2Address);
            expect(await soldierNFT.tokenURI(1)).to.equal("testURI");
        })
        it("tracks GETMYNFTS()", async() => {
            // expect(await soldierNFT.connect(user1).getMyNfts()).to.equal([1,3]);
            const arrBIG = await soldierNFT.connect(user1).getMyNfts();
            const arrJS = arrBIG.map( item => parseInt(ethers.utils.formatEther(item) * 10**18));   
            expect(arrJS).to.eql([1,3]);
        })
        it("tracks getMyStructs", async() => {
            expect(await soldierNFT.connect(user1).getMyStructs()).to.equal([4,5])
        })




        // it("tracks if claim method works", async()=>{
        //     const user1address = await user1.getAddress();
        //     const deployeraddress = await deployer.getAddress();
        //     await eternal.connect(user1).claimFree1k();
        //     await eternal.connect(deployer).claimFree1k();
        //     expect(await eternal.balanceOf(user1address)).to.equal(1000);
        //     expect(await eternal.balanceOf(deployeraddress)).to.equal(10100);
        // })
    })
})