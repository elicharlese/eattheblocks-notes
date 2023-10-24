pragma solidity ^0.6.0;

// 2. import keyword
import 'ContractB.sol';

contract MyContract {
    // Make sure the compiler has a check mark
    uint data;

    constructor(uint _data) public {
        data = _data;
    }

    function get() external view returns(uint) {
        /*
        This function will not send data to the blockchain.
        No gas is needed for this function. Just reading data.
        */
        return data;
    }

    function set(uint _data) external {
        /*
        This function will send data to the blockchain.
        You will have to pay gas in order to fun the function.
        */
        data = _data;
    }

    // The contracts will be running on the JVM using ganache
    // A test blockchain for developers which is totally separate from the mainnet on Ethereum

    // Deploy using the Injected Web3

    // We can set the specific gas limit for a contract
    // We can also select the type of value by which we want to enter the amount of gas

    // Deploy Button
    // pass in the amount of your variable

    // You can have multiple instances of your smart contract
    // Anything you do to one instance will be indepedant of what you do to another smart contract

    // Different buttons correspond to the different functions on your smart contract
    // There will be information about the transaction set and there will also be error messages


    // After you change code on your smart contract you need to redeploy to interact with the new version.


    // -------------- Control Strcutures

    bool boolValue;
    function foo() external {
        if (! boolValue) {
        } else {
        // (msg.sender == 100)
        // No such things as a strict comparison
        // && and
        // || whole thing is true
        }

        for(uint i = 0; i < 10; i ++) {
            // i = 0...9
        }
        bool isOk = true;
        while(isOk == false) {
            // not possible to have an infiite loop in solidity it just wont work
            // while loops while the condition is true
            if() {
                isOk = false;
                // break / continue
            }
        }
    }
    // --------------- Array
    // Can only contain elements of the same type
    //1. storage arrays (actually stored inside the blockchain)
    //2. memory arrays (temporary only exists while you are interacting with the smart contract)
    //3. array arguments and return arrays from function

    // 1.  Storage Arrays
    uint[] myArray; // CRUD; Create, Read, Update, Delete
    // bool[] myBoolArray; // Creates an array of type boolean

    function foo() external {
        myArray.push(2); // Create
        myArray.push(3);

        myArray[1]; // Read

        myArray[0] = 20; // Update

        delete myArray[1]; // Delete; resets the value to the default type

        for(uint i = 0; i < myArray.length; i++) {
            myArray[i]
        }
        uint[2] myArrayS; // It is possible to declare the length of the array before
        // However we will lose access the push method
        uint[] myArrayD; // This is a dynamic array
    }

    // 2. Memory Arrays
    // Memory arrays have to be decalred with a specific size

    function bar() external {
        uint[] memory newArray = new uint[](10);
        // Cannot use .push()
        newArray[0] = 10;
        newArray[1] = 20; // Create

        newArray[0]; // Read

        newArray[0] = 200; // Update

        delete newArray[5]; // Delete
    }

    //3. Arrays in functions
    // function fooBar(uint[] calldata myArg) external {
        // with external we use calldata
        // with public & internal we use memory
        // if we want to return an array from a fn we use returns(uint[] memory)
    // function fooBar(uint[] memory myArg) internal returns(uint[]  memory) {
}

contract Mappings {
    //1. declare mappings
    //2. CRUD
    //3. Default values
    //4. Exotic mapping 1: nested mappings
    //5. Exotic mapping 2: array inside mapping

    {
        a: 1,
        b: 2,
    }
    // Mappings are similar, keys and values
    // Advantage: Easy to retrieve values, you need to enter the key to get the value
    // Disadvantage: Not possible to iterate overall the entries in your mapping
    // Combin both arrays and mappings in your data

    //1. declare mappings
    mapping(address => uint) balances;
    mapping(address => mapping(address => bool)) approved;
    mapping(address => unit[]) scores;

    //2. CRUD
    function foo(address approved) external {
        //1 - Create
        balances[msg.sender] = 100;
        //2 - Read
        balances[msg.sender];
        //3 - Update
        balances[msg.sender] = 200;
        //4 - Delete
        delete balances[msg.sender];
    }

    //3. Default values
    // All keys are accessible even the ones that do not exist
    // You will still get the default value
    balances[someAddressThatDoesNotExist] => 0

    //4. Exotic mapping 1: nested mappings
    approved[msg.sender][approved] = true; // Create
    approved[msg.sender][approved]; // Read
    approved[msg.sender][approved] = false; // Update
    delete approved[msg.sender][approved]; // Delete

    //5. Exotic mapping 2: array inside mapping
    scores[msg.sender].push(1); // Create
    scores[msg.sender][0]; // Read
    scores[msg.sender] = 10; // Update
    delete scores[msg.sender][0]; // Delete
}

contract MyStruct {
    // Repressent structured data in your dataset
    // Same template, different fields for different instances
    // Similar to classes in javascript
    // You can only define fields not methods

    //1. declare struct
    //2. CRUD
    //3. Array of struct
    //4. Mapping of struct

    //1. declare struct
    struct user {
        address addr;
        uint score;
        string name;
    }

    // Create array
    User[] users;

    // Create mapping
    mapping(address => User) userList2;

    //2. CRUD
    function foo(string calldata _name) external {
        User memory user1 = User(msg.sender, 0, _name); // Create
        User memory user2 = User(msg.sender, 0, _name);
        User memory user3 = User(name: _name, score: 0, address: msg.sender); // more verbose
        user3.addr; // Read
        user3.score = 10; // Update
        delete user1; // Delete
        //3. Array of struct
        users.push(User(...)); // directly put in parameters or...
        user.push(user1); // create before hand and pass through

        //4. Mapping of struct
        userList2[msg.sender] = user2;
        userList2[msg.sender] = User(); // directly put in parameters...
    }
}

contract myEvent {
    // Allows smart contract to push data to the blockchain and webapps
    // 2 step process

    event NewTrade (
        uint date,
        address indexed from, // more expensive in ETH; you can use a max of 3
        address indexed to,
        uint amount,
    );

    function trade(address to, uint amount) external {
        emit NewTrade(now, msg.sender, to, amount);
    }

    // Smart contracts cannot read events from the past
    // Smart contracts cannot read them
    // Not a storage variable
    // One-way process
    // Gas cost is lower than storage variables
}

contract A {
    //1. call function of other contract
    // Interface of B => B
    // address of B
    address addressB;

    function setAddressB(address _addressB) external {
        addressB = _addressB;
    }

    function callHelloWorld() external view returns(string memory) {
        InterfaceB b = InterfaceB(addressB);
        return b.helloWorld();
    }
    //2. import keyword (line 3)
    //3. contract interface (contractB.sol: line 4)
    //4. error propagation

}