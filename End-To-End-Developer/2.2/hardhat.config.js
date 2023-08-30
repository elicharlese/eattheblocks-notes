require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "mainnet",
  networks: {
    hardhat: {
    },
    goerli: {
      url: "https://goerli.infura.io/v3/52fa75ec651f423a88b6d9f3d7fff6aa",
      accounts: [""] //TODO: Add Private keys for goerli wallet
    },
  },
  // Verifying your smart contract
  etherscan: {
    apiKey: ""
  },
  solidity: "0.8.19",
};
