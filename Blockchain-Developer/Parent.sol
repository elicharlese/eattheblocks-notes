pragma solidity ^0.6.0;

contract Parent {
    uint data;

    constructor(uint initialData) public {
        data = initialData;
    }
    function foo() internal {}
}