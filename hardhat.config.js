require("@nomiclabs/hardhat-waffle");
const projectId = '2cc7f3a11ab641b9bf78eca6897ff32f'

module.exports = {
  defaultNetwork: 'hardhat',
  networks:{
    hardhat: {
      chainId: 1337, //config standard
    },
    rinkeby:{
      url: `https://rinkeby.infura.io/v3/${projectId}`,
      accounts:[]
    },
    mainnet:{
      url: `https://mainnet.infura.io/v3/${projectId}`,
      accounts: []
    }
  },
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
};
