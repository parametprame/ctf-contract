import { ethers } from "hardhat";

async function main() {
  const CaptureTheFlag = await ethers.getContractFactory("CaptureTheFlag");
  const captureTheFlag = await CaptureTheFlag.deploy("TO DO ADD FORWARDER");

  await captureTheFlag.deployed();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
