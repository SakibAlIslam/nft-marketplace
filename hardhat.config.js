require("@nomiclabs/hardhat-waffle");
const projectId = '2cc7f3a11ab641b9bf78eca6897ff32f'
const fs = require("fs")
const keyData = fs.readFileSync('./p-key.txt', {
  encoding: 'utf', flag: 'r'
})

module.exports = {
  defaultNetwork: 'hardhat',
  networks:{
    hardhat: {
      chainId: 1337, //config standard
    },
    rinkeby:{
      url: `https://rinkeby.infura.io/v3/${projectId}`,
      accounts:[keyData]
    },
    mainnet:{
      url: `https://mainnet.infura.io/v3/${projectId}`,
      accounts: [keyData]
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
