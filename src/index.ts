/*
 * @Author: huajian
 * @Date: 2023-07-08 22:00:06
 * @LastEditors: huajian
 * @LastEditTime: 2023-07-10 17:02:07
 * @Description: 
 */
import { ethers } from "ethers";
import Counter from "../artifacts/contracts/Counter.sol/Counter.json";

async function hasSigners(): Promise<boolean> {
    //@ts-ignore
    const metamask = window.ethereum;
    const signers = await (metamask.request({ method: 'eth_accounts' }) as Promise<string[]>);
    return signers.length > 0;
}

async function requestAccess(): Promise<boolean> {
    //@ts-ignore
    const result = (await window.ethereum.request({ method: 'eth_requestAccounts' })) as string[];
    return result && result.length > 0;
}

async function getContract() {
    const address = '0xe7f1725e7734ce288f8367e1bb143e90bb3f0512';
    console.log(1111, address)

    if (!(await hasSigners()) && !(await requestAccess())) {
        console.log("You are in trouble, no one wants to play");
    }

    // @ts-ignore
    const provider = new ethers.providers.Web3Provider(window.ethereum).getSigner()
    const contract = new ethers.Contract(
        address,
        Counter.abi,
        provider
    );

    const setCounter = function (count: any) {
        document.querySelector('#dd').innerHTML = count;
    };

    contract.on(contract.filters.CounterInc(), setCounter);

    document.querySelector('#submit').addEventListener('click', async function () {
        await contract.count();
    })
}


getContract();