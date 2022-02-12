require("@nomiclabs/hardhat-waffle");

module.exports = {
  defaultNetwork: 'hardhat',
  networks:{
    hardhat: {
      chainId: 1337, //config standard
    },
    rinkeby:{
      url:'https://rinkeby.infura.io/v3/2cc7f3a11ab641b9bf78eca6897ff32f'
    }
  },
  solidity: "0.8.4",
};
