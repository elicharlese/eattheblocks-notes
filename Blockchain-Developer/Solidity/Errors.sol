pragma solidity ^0.6.0;

contract MyContract {
    // 1. what happened when there is an error?
    // 2. throw
    // 3. revert()
    // 4. require()
    // 5. assert()
    // 6. error in other contracts

    uint a;
    function foo() external {
        // a = 10;
        // Either up to the error or the whole gas will be consumed based on the structure of the contract
        //
        //
        // BOOM! error
        // The following code will not run
        // Also any state changes will be reversed

        // throw; this is from solidity 0.5.0 and older
        // if(a == 10) {
        //     revert('this is why the error reverts');
        // }
        require(a != 10, 'this is why it reverts');
        // More for runtime
        assert(a != 10); // This variable should never never equal 10
        // Analyze your smart contract
    }

    function willThrow() external {
        // revert('because reasons');
        // require(a != 10, 'this is why it reverts');
        // assert(true == false); // VM error: invalid opcode
    }
    function willThrowInOtherContract() external {
        B b = new B();
        // b.bar(); // it will fail all around

        // call() is a low-level way of calling smart contracts, vulnerable to re-entrancy attacks. Avoid if possible.
        address(b).call(abi.encodePacked("bar()")); // catch the errors by unit and integration testing beforehand
    }
}

contract B {
    function bar() external {
        revert('beacuse other reasons');
    }
}