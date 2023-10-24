pragma solidity ^0.6.0;

import './Parent.sol';
import './Parent2.sol';

contract Child is Parent {
    constructor(uint initialData) public Parent(initialData) Parent2() {
        // data = 10
    }

    function bar() external {
        foo();
        data++;
    }
}