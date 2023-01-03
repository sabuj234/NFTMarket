const hre = require("hardhat");

async function main() {
  const BlueToken = await hre.ethers.getContractFactory("BlueToken");
  const blueToken = await BlueToken.deploy(100000000, 50);

  await blueToken.deployed();

  console.log("Blue token deployed!! ", blueToken.address)
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
