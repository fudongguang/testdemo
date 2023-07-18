// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Ownable.sol";
import "./SafeMath.sol";

contract ZombicFactory is Ownable {
    using SafeMath for uint256;
    //部署验证
    bool public checkDeployTest = false;
    // 基因位数
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    //冷却时间
    uint public cooldownTime = 1 days;
    //僵尸单价
    uint public zombicPrice = 0.01 ether;
    //僵尸总数
    uint public zombicCount = 0;

    struct Zombic {
        string name;
        uint16 dna;
        uint16 winCount;
        uint16 loseCount;
        /** 等级 */
        uint32 level;
        /** 冷却时间 */
        uint32 cooldownTime;
    }

    Zombic[] public zombics;
    /** 僵尸id=》拥有者 */
    mapping(uint => address) public zombicToOwber;
    /** 拥有者=》僵尸数量 */
    mapping(address => uint) ownerZombicCount;
    /** 喂食次数 */
    mapping(uint => uint) zombicFeedTimes;

    event NewZombic(uint zombicId, string name, uint dna);

    function _generateRandomDna(
        string memory _str
    ) private view returns (uint16) {
        return
            uint16(
                uint(keccak256(abi.encodePacked(_str, block.timestamp))) %
                    dnaModulus
            );
    }

    function _createZombic(string memory _name, uint16 _dna) internal {
        zombics.push(Zombic(_name, _dna, 0, 0, 1, 0));
        uint id = zombics.length - 1;
        zombicToOwber[id] = msg.sender;
        ownerZombicCount[msg.sender] = ownerZombicCount[msg.sender].add(1);
        zombicCount = zombicCount.add(1);
        emit NewZombic(id, _name, _dna);
    }

    function createZombic(string memory _name) public {
        require(ownerZombicCount[msg.sender] == 0, "error");
        uint16 randDna = _generateRandomDna(_name);
        randDna = randDna - (randDna % 10);
        _createZombic(_name, randDna);
    }

    function buyZombic(string memory _name) public payable {
        require(ownerZombicCount[msg.sender] > 0, "error");
        require(msg.value > zombicPrice, "error");

        uint16 dna = _generateRandomDna(_name);
        dna = dna - (dna % 10) + 1;
        _createZombic(_name, dna);
    }

    function setZombicPrice(uint _price) external onlyOwner{
        zombicPrice = _price;
    }
}
