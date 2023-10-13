// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract MyContract {

    // ------------ Variable Types
    // 1. fixed-size types
    bool isReady; // true or false
    uint a; // 128-bit
    address recipient;
    bytes32 data;
    
    // 2. variable-size types
    string name;
    bytes _data;
    uint[] amounts; // not possible to have mixed arrays (less flexible than javascript)
    mapping(uint => string) users; // can be mapped to anything
    
    // 3. user-defined data
    struct User {
        // Must initiate a single user since there is no container
        // Then you have to put the user somewhere
        
        uint id;
        string name;
        uint[] friendIds;
    }
    enum Color {
        RED,
        GREEN,
        BLUE
    } 
    // These are being used as labels
    Color.RED, Color.GREEN

    // -------------- Built-In Variables
    msg.sender; // who the sender is of the currency
    msg.value; // value in crypto if none = 0
    
    now; // timestamp in UNIX, can be manipulated by miners
    // block in which transaction is mined.
    block.timestamp // now alternate

    // -------------- Constructors    
    // Fn with initilization code for when you run your Smart Contract
    // Only run one time, after that it never runs again
    uint a;

    constuctor(uint _a) public {
        a = _a;
    }

    // older 0.4 
    function myContract {
        
    }

    // ------------- Functions
    uint value;

    function getValue() external view returns(uint) { // view only
        return value;
    }

    function setValue(uint _value) external { // w/o CAN modify data on the blockchain
        value = _value;
    }

    // ------------- Function Visibility 
    // Who can have access to your contract
    
    // private
    // Most restricitve
    // only call function from inside the smart contract
    // Prefix the name with an underscore; this is a convention not formal for solidity

    // internal
    // Still private
    // Limited to called within the Smart Contract
    // But can be called from Smart Contracts that inherit the fn

    // external
    // only call from outside smart contract
    // do not prefix with an _

    // public 
    // call outside and inside the smart contract

    // Which visibility 
    // minimum amount of privaledge


    // ------------ Variable Visibility
    // uint private a; // can only be used within the same smart contract
    // Only valid within the EVM; but it is stored on the public blockchain (no secrets in private variables)

    // uint internal a; // can be read inside or inherited contracts

    // uint public a; // within smart contracts, inherit and outside
    // create a public function with the same name as the variable
    // therefore you cannot create a public variable with the same name as a function

    // uint a; // solidity considers this a private variable
    
    function foo() external {
        uint b = a + 1;
    }
    
}

