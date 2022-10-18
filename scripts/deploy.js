require

const main= async()=>{
  try{
     
    const nftFactory=await hre.ethers.getContractFactory("ChainBattles");
    const nftContract=await nftFactory.deploy();
    await nftContract.deployed();

    console.log("Contract has been deployed to address: ",nftContract.address)
    process.exit(0);

  }catch(error){
    console.log(error);
    process.exit(1);
  }
}

main();

// Contract deploy at ------>0x72279361fA927b618Cf282b1994bC0C6861DF598

// How to verify a smart contract
//npx hardhat verify --network mumbai 0x72279361fA927b618Cf282b1994bC0C6861DF598
//          This is the network<--^           ^-->This is the ChainBattles smart contract adress