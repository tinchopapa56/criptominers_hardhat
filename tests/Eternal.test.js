const { expect } = require("chai")
const {ethers} = require("hardhat")

describe("Eternal Token", () =>{
    let eternal;
    let deployer, user1, user2, users;
    // let URI = "testURI"
    // let postHash= "testhash"
    beforeEach(async ()=>{
        [deployer, user1, user2, ...users] = await ethers.getSigners();
        const eternalContractFactory = await ethers.getContractFactory("Eternal");
        eternal = await eternalContractFactory.deploy(100);
        // await eternal.connect(user1).mint(URI)
    })
    describe("deployment", async()=>{
        it("tracks name & symbol", async() => {
            expect(await eternal.name()).to.equal("Eternal");
            expect(await eternal.symbol()).to.equal("ETR");
        })
        it("tracks initial supply", async()=>{
            expect(await eternal.totalSupply()).to.equal(100)
        })
    })
    describe("claim free 1k/10k", async()=>{
        it("tracks initial amount of token user1", async()=>{
            const user1address = await user1.getAddress();
            expect(await eternal.balanceOf(user1address)).to.equal(0);
        })
        it("tracks if claim method works", async()=>{
            const user1address = await user1.getAddress();
            const deployeraddress = await deployer.getAddress();
            await eternal.connect(user1).claimFree1k();
            await eternal.connect(deployer).claimFree1k();
            expect(await eternal.balanceOf(user1address)).to.equal(1000);
            expect(await eternal.balanceOf(deployeraddress)).to.equal(10100);
        })
    })
})