import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem"; // Assuming this is a correct plugin import
import "@nomiclabs/hardhat-waffle";
import "@nomicfoundation/hardhat-verify";
import dotenv from 'dotenv';

dotenv.config();

const { DEPLOYER_PRIVATE_KEY, ALCHEMY_API_KEY_BASE, ALCHEMY_API_KEY_OPTIMISM, ALCHEMY_API_KEY_SEPIOLA, ETHERSCAN_API_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.24", // Use the most recent version specified
  paths: {
    sources: "./contracts",
    artifacts: './artifacts',
    cache: "./cache",
  },
  networks: {
    base: {
      url: `https://opt-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY_BASE}`,
      accounts: [`0x${DEPLOYER_PRIVATE_KEY}`],
      chainId: 8453,
    },
    optimism: {
      url: `https://opt-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY_OPTIMISM}`,
      accounts: [`0x${DEPLOYER_PRIVATE_KEY}`],
      chainId: 10,
    },
    sepiola: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY_SEPIOLA}`,
      accounts: [`0x${DEPLOYER_PRIVATE_KEY}`],
      chainId: 11155111,
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  },
  sourcify: {
    enabled: true
  }
};

export default config;