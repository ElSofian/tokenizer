import { ethers } from "ethers";
import * as dotenv from "dotenv";
import { readFileSync } from "fs";

dotenv.config();

async function main() {
  const provider = new ethers.JsonRpcProvider(process.env.SEPOLIA_RPC_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY!, provider);
  
  console.log("Deploying with account:", wallet.address);

  const artifact = JSON.parse(readFileSync("./artifacts/contracts/Token42.sol/Token42.json", "utf8"));
  
  const factory = new ethers.ContractFactory(artifact.abi, artifact.bytecode, wallet);
  const token = await factory.deploy(1_000_000);
  await token.waitForDeployment();

  const address = await token.getAddress();
  console.log("Token42 deployed to:", address);
  console.log("Network: Sepolia testnet");
  console.log(`Etherscan: https://sepolia.etherscan.io/address/${address}`)
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});