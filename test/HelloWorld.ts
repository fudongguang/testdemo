/*
 * @Author: huajian
 * @Date: 2023-07-08 21:02:27
 * @LastEditors: huajian
 * @LastEditTime: 2023-07-08 22:56:34
 * @Description: 
 */
import  "@nomiclabs/hardhat-ethers";

import { ethers } from "hardhat";
import { expect } from "chai";

describe("Hello World", () => {
    it("should get the hello world", async () => {
        const HW = await ethers.getContractFactory("HelloWorld");
        const hello = await HW.deploy() as any;


        expect(await hello.hello()).to.equal("Hello, World");
    });
});