pragma solidity ^0.6.0;

contract MyContract {
    // 1. modifier syntax
    // 2. passing arguments
    // 3. chaining modifiers
    // 4. example for access control

    // function foo(uint a) external myModifier1(a) myModifier2(a) {
    //     //do some stuff
    //     // When the fn is called it will need to pass the require statement in the Modifier first
    //     // We can forward the function arguments to the modifier to check the args first
    //     // You can also chain modifiers
    // }

    address admin;

    function foo(uint a) external onlyAdmin() {
        // can only be called by the admin
    }

    modifier myModifier1(uint a) {
        // it is internal by default it cannot be external
        // Only after it passes the modifier will the rest of the code run
        require(a == 10, 'my error message');
        _;
    }

    modifier myModifier2(uint a) {
        require(a == 10, 'my error message');
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, 'my error message');
        _;
    }
}