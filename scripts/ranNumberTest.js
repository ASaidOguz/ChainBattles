const hre = require("hardhat");


async function main(){
const[user]=await hre.ethers.getSigners();

const ChainBattles=await hre.ethers.getContractFactory("ChainBattles");
const Chainbattles=await ChainBattles.deploy();
await Chainbattles.deployed();
console.log("ChainBattles contract has been deployed :",Chainbattles.address)

const ranNumber= await Chainbattles.connect(user).random(100)
console.log("THe random number is :",Number(ranNumber));

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  