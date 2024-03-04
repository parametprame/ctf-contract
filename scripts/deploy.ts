import { ethers } from "hardhat";

async function main() {
  const TestPaymasterEverythingAccepted = await ethers.getContractFactory(
    "TestPaymasterEverythingAccepted"
  );
  const testPaymasterEverythingAccepted =
    await TestPaymasterEverythingAccepted.deploy();

  await testPaymasterEverythingAccepted.deployed();

  await testPaymasterEverythingAccepted.setRelayHub(
    "0x3CBbeD88606DaA4dBa90E9FDEaf86Bc13715BfA2"
  );

  await testPaymasterEverythingAccepted.setTrustedForwarder(
    "0xe5c83e93184512aE574c624ADf05B192AcF361FD"
  );

  console.log(
    "testPaymasterEverythingAccepted Contract deployed to:",
    testPaymasterEverythingAccepted.address
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
