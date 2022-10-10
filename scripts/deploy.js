const {ethers} = require("hardhat");

async function main() {
  const eternalContract= await ethers.getContractFactory("Eternal");
  const deployedEternalContract = await eternalContract.deploy(100000); //
  await deployedEternalContract.deployed();

  console.log("The address der EternalContract:", deployedEternalContract.address);
}


main()
  .then(()=> process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
