const hre = require("hardhat");

async function main() {
  const Faucet = await hre.ethers.getContractFactory("Faucet");
  const faucet = await Faucet.deploy("0xc30756E86378c01ec7F3dA8D6dE90fbC215f1022"); // add the address of ERC20 token

  await faucet.deployed();

  console.log("Faucet contract deployed!! ", faucet.address)
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
