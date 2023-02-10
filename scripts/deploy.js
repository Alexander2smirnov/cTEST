const hre = require("hardhat");

require('dotenv').config();

async function main() {
  const TEST = await hre.ethers.getContractFactory("TEST");
  const testContract = await TEST.deploy();

  await testContract.deployed();

  const testAddress = testContract.address;

  console.log(
    `TEST token is deployed to ${testAddress}`
  );

  const cTEST = await hre.ethers.getContractFactory("cTEST");
  const cTestContract = await cTEST.deploy(testAddress);

  await cTestContract.deployed();

  console.log(
    `cTEST token is deployed to ${cTestContract.address}`
  );

  await testContract.mint(cTestContract.address, '0x3635C9ADC5DEA00000');  // 10^24 (1 000 000)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
