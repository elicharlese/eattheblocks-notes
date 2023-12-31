pragma solidity ^0.8.21;
pragma experimental ABIEncoderV2;

contract Wallet {
    address[] public approvers;
    uint public quorum;

    struct Transfer {
        uint id;
        uint amount;
        address payable to;
        uint approvals;
        bool sent;
    }

    // mapping(uint => Transfer) public transfers;
    // uint public nextId;
    Transfer[] public transfers;
    mapping(address => mapping(uint => bool)) public approvals;

    constructor(address[] memory _approvers, uint _quorum) public {
        approvers = _approvers;
        quorum = _quorum;
    }

    function getApprovers() external view returns(address[] memory) {
        return approvers;
    }

    function getTransfers() external view returns(Transfer[] memory) {
        return transfers;
    }

    // function createTransfer(uint amount, address payable to) external {
    //     transfers[nextId] = Transfer(
    //         nextId,
    //         amount,
    //         to,
    //         0,
    //         false
    //     );
    //     nextId++;
    // }
    function createTransfer(uint amount, address payable to) external onlyApprover() {
        transfers.push(Transfer(
            transfers.length, // id = 0; id.push()
            amount,
            to,
            0,
            false
        ));
    }

    function approveTransfer(uint id) external onlyApprover() {
        require(transfers[id].sent == false, 'transfer has already been sent'); // variable and error message
        // transfers is an array you push to with the id we check the status of the sent request
        require(approvals[msg.sender][id] == false, 'approval has already been');

        approvals[msg.sender][id] = true;
        transfers[id].approvals++;

        if(transfers[id].approvals >= quorum) {
            transfers[id].sent = true;
            address payable to = transfers[id].to;
            uint amount = transfers[id].amount;
            to.transfer(amount);
        }
    }

    // function sendEther() external payable {}; // There is a better way to this
    // If we send ether without a fn address we will automatically trigger this fn
    receive() external payable {}

    modifier onlyApprover() {
        bool allowed = false;
        for(uint i = 0; i < approvers.length; i++) {
            if(approvers[i] == msg.sender) {
                allowed = true;
            }
        }
        require(allowed == true, 'only approver allowed');
        _;
    }
}
