pragma solidity ^0.6.0;

// Ether units in Solidity - official Solidity documentation
contract MyContract {
    function foo(address payable to, uint amount) external {
        to.transfer(amount); // you can specify the amount as well; it is in wei
        // 1 wei = 10 ^ -18 ether = 0.0000....1
    }

    function bar() external payable {
        msg.value;
        address(this).balance;
    }

    fallback() external {
        // This function will be called if you call a fn on the smart contract that does not exist
        // It can be made payable but it is better to have the receive fn be payable
    } // fallback function

    receive() external payable {
        // You can use this here to receive the ether if a fn that doesn't exist is called
    }
}

