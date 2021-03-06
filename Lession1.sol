pragma solidity >= 0.5.0 < 0.6.0 //1. Enter solidity version here

//2. Create contract here
contract ZombieFactory {

  // Events are a way for your contract to communicate that something happened on the blockchain to your app front-end
  event NewZombie(uint zombieId, string name, uint dna);
  
  // State variables will be stored permanently in the blockchain
  // The uint data type is an unsigned integer (non-negative)
  // uint is actually an alias for uint256
  uint dnaDigits = 16;

  // Math Operations
  // Addition: x + y
  // Subtraction: x - y,
  // Multiplication: x * y
  // Division: x / y
  // Modulus / remainder: x % y (for example, 13 % 5 is 3, because if you divide 5 into 13, 3 is the remainder)
  uint dnaModulus = 10 ** dnaDigits;

  // Use structs to define complex data type
  struct Zombie {
    string name;
    uint dna;
  }

  // Use array when want to collection of something
  // There are two types of arrays in Solidity: fixed arrays and dynamic arrays
  Zombie[] public zombies; // dynamic arrays

  // memory: This is required for all reference types such as arrays, structs, mappings, and strings.
  // In Solidity, functions are public by default
  // This means anyone (or any other contract) can call your contract's function and execute its code
  function _createZombie(string memory _name, uint _dna) private {
    // Add new Zombie to zombies
    // array.push() returns a uint of the new length of the array
    uint id = zombies.push(Zombie(_name, _dna)) - 1;

    emit NewZombie(id, _name, _dna);
  }

  // view function: meaning it's only viewing the data but not modifying it
  // pure function: you're not even accessing any data in the app, return value depends only on its function parameters
  function _generateRandomDna(string memory _str) private view returns (uint) {
    // keccak256: SHA3
    // keccak256 expects a single parameter of type bytes
    // So we have to "pack" any parameters before calling keccak256
    // uint(...) Typecasting
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function createRandomZombie(string memory _name) public {
    uint randDna = _generateRandomDna(_name);
    _createZombie(_name, randDna);
  }
}