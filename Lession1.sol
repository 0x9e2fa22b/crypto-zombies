pragma solidity >= 0.5.0 < 0.6.0 //1. Enter solidity version here

//2. Create contract here
contract ZombieFactory {
  
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
  function createZombie(string memory _name, uint _dna) public {
        
  }
}