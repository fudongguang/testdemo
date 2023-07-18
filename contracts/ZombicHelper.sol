// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import './ZombicFactory.sol';

contract ZombicHelper is ZombicFactory{
    /** 升级费用 */
    uint leveUpFee = 0.001 ether;

    modifier aboveLevel(uint _level,uint _zombicId){
        require(zombics[_zombicId].level>=_level,'error');
        _;
    }

    modifier onlyOwnerOf(uint _zombicId){
        require(msg.sender == zombicToOwber[_zombicId],'error');
        _;
    }

    modifier isReady(Zombic storage _zombic){
        require(_isReady(_zombic),'error');
        _;
    }

    function setUpLevelFee(uint _fee) external onlyOwner{
        leveUpFee = _fee;
    }

    function leveUp(uint _zombicId) external payable{
        require(msg.value>=leveUpFee,'sdf');
        zombics[_zombicId].level++;
    }

    /** external 外部调用函数 必须使用 calldata 不能使用memory */
    function changeName(string calldata _name,uint _zombicId) external aboveLevel(2, _zombicId) onlyOwnerOf(_zombicId){
        zombics[_zombicId].name=_name;
    }

    function getZombicsByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerZombicCount[_owner]);
        uint counter = 0;
        for(uint i=0;i<zombics.length;i++){
            if(zombicToOwber[i]==_owner){
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function triggerCooldown(Zombic storage _zombic) internal {
        _zombic.cooldownTime = uint32(block.timestamp+cooldownTime)-uint32((block.timestamp+cooldownTime)% 1 days);
    }

    function _isReady(Zombic storage _zombic) private view returns (bool){
        return _zombic.cooldownTime<=block.timestamp;
    }

    function muliply(uint _zombicId,uint _targetDna) internal onlyOwnerOf(_zombicId) isReady(zombics[_zombicId]){
        Zombic storage myZombic = zombics[_zombicId];
        _targetDna = _targetDna% dnaModulus;
        uint newDna = (myZombic.dna+_targetDna)/2;
        newDna = newDna - newDna%10 + 9;
        _createZombic("NoName", uint16(newDna));
        triggerCooldown(myZombic);
    }

}