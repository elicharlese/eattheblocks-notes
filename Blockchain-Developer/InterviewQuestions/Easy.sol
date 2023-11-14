// 1. What is an Ethreum smart contract?
// It's a small program that runs on the Ethreum blockchain.

// 2. What makes ETH smart contracts special compared to other programs?
// it cannot be stopped, hacked or modified

// 3. Can a smart contract interact with other smart contracts?
// yes (chain of execution)

// 4. Can a Solidity smart contract call an API on the web?
// no (only interact with its own code and other code on smart contracts on the blockchain)

// 5. Can a solidity smart contract store a lot of data?
// no (cost gas to store data)

// 6. Is Solidity the only smart contract language?
// Vyper, LLL, others (Solidity is the most popular)

// 7. Is Solidity a dynamically or statically typed language?
// statically typed (variables need to be defined by type; be explicit)

// 8. Is Solidity compiled or interpreted?
// compiled (not Just in Time compilation)

// 9. File extension for Solidity?
// .sol

// 10. Can a single Solidity file have several smart contracts?
// yes (define them throughout the contract)

// 11. What is the typical layout of a Solidity smart contract?
// pragma statement (required)
// pragma solidity ^0.5.9;

// contract declaration (required)
// contract A {
    // state variables
    // uint a;

    // functions
    // function foo() {...}
// }

// 12. What is the difference between state and local variables?
// state variable
// uint a;

// functions
// function foo() {
    // uint b; // local variable
// }

// 13. What is the problem with the following code?
// contract Storage {
    // uint data;

    // Should update the `data` storage variable above
    // function set(uint _data) external {
        // address data = _data;
    // }
// }
//

// 14.What is the problem with the following code?
// contract Storage {
    // uint data;
    // Should update the `data` storage variable above
    // function set(uint data) external {
        // data = data?
    // }
// }


// 15. What are the 2 visibilities for state variables?
// private & public

// 16. Who can reac private and public variables?
// private => inside contract
// public => anyone

// 17. What is the default visibility of state variables?
// private

// 18.Are private variables really private?
// no, can be inspected on blockchain    

// 19. How to deal with private data then?
// solution 1: no private data on blockchain
// solution 2: use hashes

// 20. Mention 3 data types that you use often, and explain why
// uint, ether and token transfers
// address, identifying humans and smart contracts
// string, writing things

// 21. What are the 2 types of containers in Solidity?
// mappings and arrays

// 22. How to decalre an array of integer in Solidity/
// uint[] a;

// 23. How to declare a mapping of address to booleans in Solidity?
// mapping(address => bool) a;

// 24. How to declare a mapping of address to mapping of address to booleans (nested mapping)?
// mapping(address => mapping(address => bool)) a;

// 25. How to add data to an array declared as a state variable?
// uint[] a;

// function add(uint newEntry) external {
    // add.push(a);
// }

// 26. How to add data to a mapping declared as a state variable?
// mapping(address => bool) a;

// function add(address addr) external {
    // a[addr] = true;
// }

// 27 How to loop through an array?
// uint[] a;
// for(uint i = 0; i < arr.length; i++) {
    // do something with arr[i]
    // reading: uint a = arr[i]
    // writing: arr[i] = a
// }

// 28. What is the difference between a uint8 and a uint16?
// uint8 -> 2^8-1
// uint16 -> 2^16-1

// 29. What are the 4 function visibilities in Solidity,by increasing permissiveness?
// private, internal, external, public

// 30. How to conditionally throw an error, with an error message?
// require(a !== b, 'My error message')

// 31. What are the 2 artifacts produced by the Solidity compiler when compilibng a smart contract? 
// abi, bytecode

// 32. What is the ABI of a smart contract?
// define interface of a contract (omly the function signatures)

// 33. In the follwoing contract, which function will be part of the ABI?
// contract A {
    // function foo() external {...}
    // function bar() public {...}
    // function baz() internal {...}
// }

// 34. Does the EVM understand solidity?
// no, only bytecode

// 35. What is the EVM bytecode?
// a series of EVM opcodes

// 36. What are the 2 APIs used to interact with a smart contract?
// eth_sendTransaction: costs money and can modify data on the blockchain
// eth_call: free and read only

// 37. What is gas?
// an abstract uint to measure transaction cost


// 38. How is gas paid?
// ether cost = gasPrice * gas, sent by the sender of the transaction, specified limit (without an account could be drained of Ether)

// 39. What happen if there is not enough gas in a transaction?
// transaction fails, state changes reversed

// 40. Who pays for gas in a transaction?
// sender

// 41. What is the most famous IDE for Solidity?
// Remix (remix.ethereum.org)

// 42. List 2 famous smart contract framework for Solidity
// Truffle, OpenZeppelin

// 43. What Javascript Ethrereum client can we use to develop Solidity on a local blockchain?
// Ganache

// 44. What do you need to deploy a smart contract to the Ethereum network?
// bytecode, ethereum address, ether, wallet, tool to create tx

// 45. List 4 famous Ethereum wallets
// Metamask, MyEtherwallet, Ledger, Trezor

// 46. List 3 networks where you can deploy a Solidity smart contract
// Mainnet, Ropsten, Kovan
