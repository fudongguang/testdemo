// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import './ZombicHelper.sol';

contract ZombicFeeding is ZombicHelper{
    using SafeMath for uint256;

    function feed(uint _zombicId) public onlyOwnerOf(_zombicId){
        Zombic storage myZombic = zombics[_zombicId];
        zombicFeedTimes[_zombicId] = zombicFeedTimes[_zombicId].add(1);
        triggerCooldown(myZombic);
        if(zombicFeedTimes[_zombicId]%10==0){
            uint newDna = myZombic.dna-myZombic.dna%10+8;
            _createZombic("zombic's son", uint16(newDna));
        }
    }
}