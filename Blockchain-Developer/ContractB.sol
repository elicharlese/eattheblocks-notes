pragma solidity ^0.6.0;

// 3. contract interface
contract InterfaceB {
    // You only need to include the functions you want to use
    // You can use interface instead of contract
    // However, interface is not allowed to inhereit from other interfaces
    // So people prefer the contract keyword
    function helloWorld() virtual external pure returns(string memory); // must be virtual if fn signature
    function foo() virtual external;
}

contract B {
    function helloWorld() external pure returns(string memory) {
        // any error in this contract will propogate an error in the inheriting contract
        revert();
        return 'HelloWorld';
    }

    function foo() external {
        // whatever
    }
}