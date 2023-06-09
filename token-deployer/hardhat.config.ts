import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";


require('dotenv').config();

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/JD9HMoQaFxS1HmgXOgS9sTh44Vl1xf6r",
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    },
  },
};

export default config;
