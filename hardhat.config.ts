/*
 * @Author: huajian
 * @Date: 2023-07-08 17:18:17
 * @LastEditors: huajian
 * @LastEditTime: 2023-07-19 20:54:44
 * @Description: 
 */
import 'hardhat-watcher'
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import "hardhat-gas-reporter"
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  gasReporter: {
    currency: 'USD',
    gasPrice: 21,
    enabled: false
  },
  networks: {
    hardhat: {
      chainId: 1337
    },
    polygon:{
      url:'https://matic-mumbai.chainstacklabs.com',
      chainId:80001,
      accounts:['0xac0974bec39a17e36ba4a6b4d238aa944bacb478cbed5efcae784d7bf4f2ff80']
    }
  }
};
