/*
 * @Author: huajian
 * @Date: 2023-07-08 21:02:27
 * @LastEditors: huajian
 * @LastEditTime: 2023-07-13 20:29:01
 * @Description: 
 */
import  "@nomiclabs/hardhat-ethers";

import { ethers } from "hardhat";
import { expect } from "chai";

describe("Counter", () => {
    it("should get the hello world", async () => {
        const Counter = await ethers.getContractFactory("Counter");
        const counter = await Counter.deploy() as any;
        expect(await counter.getCounter()).to.equal(15);
    });
});