pragma solidity >=0.5.0 <0.6.0;

import "./ZombieAttack.sol";

// ERC721 tokens are not interchangeable since each one is assumed to be unique, and are not divisible.
// You can only trade them in whole units, and each one has a unique ID.
// So these are a perfect fit for making our zombies tradeable.
contract ZombieOwnership is ZombieAttack {

}