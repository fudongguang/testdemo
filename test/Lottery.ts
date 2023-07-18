/*
 * @Author: huajian
 * @Date: 2023-07-08 21:02:27
 * @LastEditors: huajian
 * @LastEditTime: 2023-07-13 21:03:10
 * @Description: 
 */
import  "@nomiclabs/hardhat-ethers";

import { ethers } from "hardhat";
import { expect } from "chai";

describe("Lottery", () => {
    it("test init age", async () => {
        const Lottery = await ethers.getContractFactory("Lottery");
        const lottery = await Lottery.deploy() as any;
        expect(await lottery.age()).to.equal(1);
        expect(await lottery.getAge()).to.equal(1);
    });
});