import { ethers } from "hardhat";

async function main() {
  const initialSupply = 10000000;

  const token = await ethers.getContractFactory("DemezyToken");
  const tokenDeployed = await token.deploy(initialSupply);


  console.log(
    `deployed to ${tokenDeployed.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
