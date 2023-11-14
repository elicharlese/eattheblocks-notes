// 47. How to manage dates in Solidity?
// use uint variables

// 48. How to have the current timestamp in seconds?
// use the `now` variable

// 49. How to construct a timestamp of 1 day in the future?
// now + 86400

// 50. What are the 2 ways to define custom data structure in Solidity?
// struct, enum

// 51. When would you use a struct vs an enum?
// struct => like an object
// enum => variant of same data

// 52. What are the 2 ways to instantiate a struct?
// struct User {
    // address id;
    // string name;
// }

// Method 1 (argument order matters)
// User("0xaIO90....", "Mike");

// Method 2 (argument order does not matter)
// User({name: "Mike", address: "0xfafsafs..."});

// 53. How to instantiate a struct with inner mapping?
// You can instantiate an inner mapping even when the entry does not exist
// struct User {
    // address id;
    // string name;
    // mapping(address => bool) friends;
// }

// let assume the User struct is stored inside a mapping
// mapping(address => User) users;

// Inside a function, you would instantiate your struct like
// users["0xdfdaf"].id = "0xdfdaf";
// users["0xdfdaf"].name = "Mike";
// users["0xdfdaf"].friends["0xnsds"] = true;
// users["0xdfdaf"].friends["0xsdasa"] = true;


// 54. When would you use an array vs a mapping?
// array => to iterate
// mapping => lookup value

// 55. How to combine array and mapping to allow both iteration and rapid lookup of a struct?
// Let's consider this struct
// struct User {
    // uint id;
    // string name;
// }

// First, let's use an array to store all its ids
// uint[] userIds;

// Then, let's use a mapping for rapid lookup
// mapping(uint => User) users;

// If we need to rapidly lookup a user, we use the mapping 
// And if we need to iterate though users, we iterate through
// and for each userIf we can
// lookup the correct user in the mapping

// 56. How to define an in-memory array of 3 integers?
// uint[] memory arr = new uint[](3);

// 57. How to add value to an in memory array?
// uint[] memory arr = new uint[](3);

// uint[0] = 1;
// uint[1] = 2;
// uint[2] = 3;
// uint[3] = 1; // out-of-bounds error

// 58. How to get the list of all keys in a mapping (like Object.keys()) in Javascript?
// not possible, smart contract do not keep a list of the entries in a mapping
// need to know which key you want to address or store list of keys in a separate array

// 59. How to create an in-memory mapping?
// not possible

// 60. What happens if you access the key of a mapping that does not exist?
// Solidity will return you the default value of the type
// mapping(uint => bool) myMap; No error as opposed to error recieved on arrays

// 61. What are the 3 mechanisms for code re-use in Solidity?
// functions, inheritance, libraries

// 62. How to make a contract A inherit from a contract B in Solidity?
// First import the contract
// import B from 'path/to/B.sol';

// Then make your coontract inherit from it
// contract A is B {
    // Then call the constructor of the B contract
    // constructor() B() {}
// }


// 63. If A inherit from B, and both define the same function foo, which one will be resolved?

// CASE 1
// contract B {
    // function foo() external {...}
// }

// contract A is B {
    // function foo() external {...}
// }

// CASE 2
// contract B {
    // function foo(uint data) external {...}
// }

// contract A is B {
    // function foo() external {...}
// }

// 64. What are the 4 memory location of Solidity?
// Storage, memory, stack, calldata

// 65. What is the default visibility of state variables?
// private

// 66. What is the difference between address and address payable?
// Solidity can only send ether to address payable

// 67. Is it necessary to make an address `address payable` to transfer ERC20 tokens?
// no, only to send Ether tokens are different

// 68. What are the main changes in Solidity 0.5x vs 0.4x?
// constructors
// address payable
// var keyword removed
// emit keyword addeed
// memory location explicit for dynamic-length types

// 69. Give 3 ways to save gas
// put less data on-chain
// use events
// optimal order of variable declaration

// 70. How would you optimally order uint128, bytes 32 and another uint128 to save gas?
// uint128
// uint128
// bytes32

// 71. How to concatenate 2 strings a, b?
// string(abi.encodePacked(a, b));

// 72. How to get the length of a string in solidity?
// bytes memory byteStr - bytes(a); // a is a string
// bytesStr.length;

// 73. How to create a smart contract from a smart contract?
// contract A {
    // constructor(uint a) {...}
    // function foo() external {..}
// }

// contract B {
    // function createA(uint a) external {
        // A Ainstance = new A(a); // pass the constructor argument(s) i
    // }
// }

// 74. How to call another smart contract from a smart contract?
// contract A {
    // function foo() view external returns(uint) {...}
// }

// contract B {
    // function callFoo(address addrA) external {
        // uint result = A(addrA).foo();
    // }
// }

// 75. How to get the address of a smart contract that was deploed from a smart contract?
// address childAddress = address(new Child())

// 76. What will be the value of msg.sender if a contract call another one?
// This is the inner contract
// contract A {
    // function bar() view external returns(address) {
        // What will be the value of `msg.sender` here?
    // }
// }

// contract B {
    // function foo() external {
        // A aInstance = new A();
        // aInstance.bar();
    // }
// }

// This is the outer contract

// 77. How to transfer ERC20 tokens?
// ERC20 Interace (transfer, transferFrom) // all you need
// DEX (transferToken) // calls on the ERC20 Interface

// 78. How to declare and emit an event? 
// contract A {
    // declate event
    // Event TokenSent(uint amount, address to);
    // function sendToken(uint amount, address to) external {
        ...
        // Emit event
        // emit TokenSent(amount, to); // careful, old Solidity 0.4
    // }
// }

// 79. What is the indexed keyword in event
// Can only filter events who fields match a specific value; allows for filtering of events
// Event TokenSent(uint amount, address indexed to);

// 80. How many different fields can be marked indexed?
// 3 max

// 81. Is it possible for a smart contract to read the events emitted before?
// no, only external entities can query events

// 82. Is it possible to delete or modify a past event?
// no

// 83. In Solidity, how to do like a Javascript console.log for debugging?
// use events

// 84. How would you implement access control without modifier?
// contract A {
    // address admin;
    // constructor() {
        // admin = msg.sender;
    // }

    // function protectedFunction() external {
        // require(msg.sender == admin, 'only admin');
        // ...
    // }
// }

// 85. How would you implement access control WITH modifier?
// contract A {
    // address admin;
    // constructor() {
        // admin = msg.sender;
    // }

    // function protectedFunction() external onlyAdmin() {
        // ...
    // }

    // modifier onlyAdmin() {
        // require(msg.sender == admin, 'only admin');
        // _;
    // }
// }

// 86. How to cancel a transaction?
// send another tx with same nonce, higher gasPrice
