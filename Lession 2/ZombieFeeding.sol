pragma solidity >=0.5.0 <0.6.0;

import './ZombieFactory.sol';

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);

    // Most of the time you don't need to use these keywords because Solidity handles them by default.
    // State variables (variables declared outside of functions) are by default storage and written permanently to the blockchain,
    // while variables declared inside functions are memory and will disappear when the function call ends.
    Zombie storage myZombie = zombies[_zombieId];
  }
}