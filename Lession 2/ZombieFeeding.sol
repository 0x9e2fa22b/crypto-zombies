pragma solidity >=0.5.0 <0.6.0;

import './ZombieFactory.sol';

// Create KittyInterface here
contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  // Initialize kittyContract here using `ckAddress` from above
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);

    // Most of the time you don't need to use these keywords because Solidity handles them by default.
    // State variables (variables declared outside of functions) are by default storage and written permanently to the blockchain,
    // while variables declared inside functions are memory and will disappear when the function call ends.
    Zombie storage myZombie = zombies[_zombieId];

    // Make sure that _targetDna isn't longer than 16 digits
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (, , , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna);
  }
}