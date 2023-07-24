// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "./ZombicHelper.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ZombicOwnerShip is ZombicHelper, ERC721 {
    using SafeMath for uint256;
    /** 批准映射 */
    mapping(uint=>address) public zombicApprovals;


    constructor() ERC721("ZombicOwnerShip", "ITM") {

    }
    function balanceOf(address _owner) public override view returns(uint _balance){
        return ownerZombicCount[_owner];
    }

    function ownerOf(uint _tokenId) public override view returns(address _owner){
        return zombicToOwber[_tokenId];
    }

    function _transfer(address _from,address _to,uint _tokenId) internal override{
        ownerZombicCount[_to] = ownerZombicCount[_to].add(1);
        ownerZombicCount[_from] = ownerZombicCount[_from].sub(1);
        zombicToOwber[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
    function transfer(address _to,uint _tokenId) public{
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to,uint _tokenId) public override{
        require(zombicToOwber[_tokenId] == msg.sender,'error');
        zombicApprovals[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }
    function takeOwnership(uint _tokenId) public{
        require(zombicApprovals[_tokenId] == msg.sender,'error');
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}
