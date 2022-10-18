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

// Contract deploy at ------> 0xD3BD8A57d18ea78ff389D7d5836Af1BdadC61bF2

// How to verify a smart contract
//npx hardhat verify --network mumbai  0xD3BD8A57d18ea78ff389D7d5836Af1BdadC61bF2
//        This is the network<--^                  ^-->This is the ChainBattles smart contract adress