/*
 * @Author: huajian
 * @Date: 2023-07-08 21:22:13
 * @LastEditors: huajian
 * @LastEditTime: 2023-07-18 18:08:37
 * @Description: 
 */
import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";

async function deploy() {
    const ZombicFactory = await ethers.getContractFactory("ZombicFactory");
    const zombicFactory = await ZombicFactory.deploy();
    await zombicFactory.deployed();

    return zombicFactory;
}

// @ts-ignore
async function test(zombicFactory) {
    console.log("counter is:", await zombicFactory.checkDeployTest());
}

deploy().then(test);