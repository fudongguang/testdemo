// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import './ZombicHelper.sol';

contract ZombicAttack is ZombicHelper{
    /** 随机数种子 */
    uint randNonce = 0;

    /** 获胜概率 */
    uint attackVictoryProbablity = 70;

    function randMod(uint _modules) internal returns (uint){
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % _modules;
    }

    function attack(uint _zombicId,uint _targetId) external onlyOwnerOf(_zombicId){ 
        Zombic storage myZombic = zombics[_zombicId];
        Zombic storage enemyZombic = zombics[_targetId];
        uint rand = randMod(100);
        if(rand<=attackVictoryProbablity){
            myZombic.level++;
            myZombic.winCount++;
            enemyZombic.loseCount++;
            muliply(_zombicId, enemyZombic.dna);
        }else{
            myZombic.loseCount++;
            enemyZombic.winCount++;
            triggerCooldown(myZombic);
        }
    }
}