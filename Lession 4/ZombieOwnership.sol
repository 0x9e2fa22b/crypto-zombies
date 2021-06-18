pragma solidity >=0.5.0 <0.6.0;

import "./ZombieAttack.sol";
import "./ERC721.sol";

// ERC721 tokens are not interchangeable since each one is assumed to be unique, and are not divisible.
// You can only trade them in whole units, and each one has a unique ID.
// So these are a perfect fit for making our zombies tradeable.

contract ZombieOwnership is ZombieAttack, ERC721 {
  mapping (uint => address) zombieApprovals;

  // Return the number of zombies _owner has
  function balanceOf(address _owner) external view returns (uint256) {
    return ownerZombieCount[_owner];
  }

  // Return the owner of _tokenId
  function ownerOf(uint256 _tokenId) external view returns (address) {
    return zombieToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to]++;
    ownerZombieCount[_from]--;
    zombieToOwner[_tokenId] = _to;

    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require(zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);

    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId)  {
    zombieApprovals[_tokenId] = _approved;

    emit Approval(msg.sender, _approved, _tokenId);
  }

}