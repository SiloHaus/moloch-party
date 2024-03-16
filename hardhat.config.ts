import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import * as dotenv from 'dotenv';

dotenv.config(); // Load the environment variables from the .env file

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,
      accounts: [`${process.env.DEPLOYMENT_ACCOUNT_PRIVATE_KEY}`].map(key => `0x${key}`)
    },
    optimism: {
      url: process.env.OPTIMISM_RPC_URL,
      accounts: [`${process.env.DEPLOYMENT_ACCOUNT_PRIVATE_KEY}`].map(key => `0x${key}`),
      chainId: 10, // Use 69 for Optimism Testnet
    },
  },
};

export default config;
