// 87. What is the ABIEncoderV2 pragma statement?
// enables experimental Soldity features

// 88. Is it safe to use the ABIEncoderV2 pragma statement in production?
// No

// 89. Is it possible to send a transaction without requiriing user to pay gas?
// Yes

// 90. Which Solidity function would you use to verify a signature?
// ecrecover

// 91. What is a library in Solidity?
// re-usable piece of code
// deploy (have thier own address) and embedded (no address, inside contract)

// 92. Give an example of how to use a library in a smart contract
// library Lib {
    // function add(uint a, uint b) pure internal returns(uint) {
        // return a + b;
    // }
// }

// contract A {
    // using Lib for uint;

    // function add(uint a, uint b) pure external returns(uint) {
        // return a.add(b);
    // }
// }

// 93. When is a library embedded vs deployed?
// Embedded (function is internal)
// library Lib {
    // function add(uint a, uint b) pure internal returns(uint) {
        // return a + b;
    // }
// }

// Deployed (function is public)
// library Lib {
    // function add(uint a, uint b) pure public returns(uint) {
        // return a + b;
    // }
// }

// 94. 
// Happens between 2 contracts
// contract A {
    // ...
    // function pay(address payable to, uint amount) external {
        // if(amount <= balances[msg.sender]) {
            // B(to).badFunction().send(amount);
            // balances[msg.sender] -= amount;
        // }
    // }
// }

// contract B {
    // address
    // function badFunction(address payable to) external {
        // ContractA(msg.sender).pay(); // passes again
    // }
// }

// 95. How to prevent against a re-entrancy attack?
// Solution 1: update before calling other contract
// Solution 2: put in place re-entracy gaurd
// Solution 3: limit gas available in call contract

// 96. How to produce a hash of multiple values in Solidity?
// keccak256(abi.encodePacked(a, b, c))

// 97. How to generate a random integer in Solidity?
// uint(keccack256(abi.encodePacked(block.timestamp, block.difficulty)))

// 98. What are the 2 kind of assembly in Solidity?
// Functional: uses a function
// Instructional: series of opcodes

// 99. How to declare assembly code?
// assembly {}

// 100. Create a function to determine if another address is a contract or a regualr address
// function isHuman(address addr) external {
    // uint256 codeLength;

    // assembly {codeLength := extcodesize(addr)}
    // return codeLength == 0 ? true : false;
// }


