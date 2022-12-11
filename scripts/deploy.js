const {ethers} = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  const eternalContract= await ethers.getContractFactory("Eternal");
  const deployedEternalContract = await eternalContract.deploy(100);
  await deployedEternalContract.deployed();
  saveFrontendFiles(deployedEternalContract, "Eternal")

  const soldierContract = await ethers.getContractFactory("SoldierNFT")
  const deployedSoldierContract = await soldierContract.deploy();
  await deployedSoldierContract.deployed()
  saveFrontendFiles(deployedSoldierContract, "SoldierNFT")

  console.log("The address der EternalContract:", deployedEternalContract.address);
  console.log("The address der Soldiers Contract:", deployedSoldierContract.address);
}
function saveFrontendFiles(contract, name) {
  const fs = require("fs");
  // const contractsDir = __dirname + "/../contractsData";
  const contractsDir = __dirname + "/../../criptominers_front/src/contractsData";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + `/${name}-address.json`,
    JSON.stringify({ address: contract.address }, undefined, 2)
  );

  const contractArtifact = artifacts.readArtifactSync(name);

  fs.writeFileSync(
    contractsDir + `/${name}.json`,
    JSON.stringify(contractArtifact, null, 2)
  );
}

main()
  .then(()=> process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });

  //npx hardhat run scripts/deploy.js --network localhost