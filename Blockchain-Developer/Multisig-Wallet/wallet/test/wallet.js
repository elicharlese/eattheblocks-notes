const Wallet = artifacts.require('Wallet');

contract('Wallet', (accounts) => {
    let wallet;
    beforeEach(async () => {
        wallet = await Wallet.new([accounts[0], accounts[1], accounts[2]], 2); // we need to provide an array of approvers and the quroum (min # of approvers)
        // accounts up to 10 prefilled test wallets provided by truffle
        await web3.eth.sendTransaction({from: accounts[0], to: wallet.address, value: 1000});
        // await pauses the function in order to await the prosed value so that it is resolved and usable.
        // we are on an asynchronous time-lapse because we are manipulating the layers of events triggered on the single thread.
        // you want to make sure to run the code concurrently; you can resolve multiple values at the same time
        // you only need to await the second value when the first value is dependant upon the first value
        // the whole point of the event loop is to avoid blocking code
        // you can add your promise and have it resolve to equal a variable
        // if you wrap it in an await keyword
        // we have to consider where we will be throwing our errors, so we can account for the control flow and the users experience

        // async function with a for loop inside to iterate over values that you are waiting to resolve
        // or you can write for await (): and use the await keyword directly in your loop to run once a promise is resolved or updated
        // you can also run an await keyword in your conditionals
    });

    it('should have correct approvers and quorum', async () => {
        const approvers = await wallet.getApprovers();
        const quorum = await wallet.quorum();
        assert(approvers.length === 3);
        assert(approvers[0] === accounts[0]);
        assert(approvers[1] === accounts[1]);
        assert(approvers[2] === accounts[2]);
        // assert(quorum === 2) // This will fail bc we don't have js number but it is wrapped in a BN.js
        assert(quorum.toNumber() === 2); // we can also try to string and wrap our number in ''
    });

    it('should create transfers', async () => {
        // This will capture the transaction reciept
        await wallet.createTransfer(100, accounts[5], { from: accounts[0] }); // approver address 
        // This section will test all of the arguments in an Transfer struct
        const transfers = await wallet.getTransfers();
        assert(transfers.length === 1);
        assert(transfers[0].id === '0');
        assert(transfers[0].amount === '100');
        assert(transfers[0].to === accounts[5]);
        assert(transfers[0].approvals === '0');
        assert(transfers[0].sent === false);
        // Numbers that are fields of struct are not wrapped in BN.js objects,
        // but are string instead...Need to change the way we compare numbers...
    });
    
    it('should NOT create transfers if sender is not approved', async () => {
        await expectRevert(
            wallet.createTransfer(100, accounts[5], {from: accounts[4]}),
            'only approver allowed'
        );
    });
    
    it('should increment approvals', async () => {
        await wallet.createTransfer(100, accounts[5], {from: accounts[0]});
        await wallet.approveTransfer(0, {from: accounts[0]});
        const transfers = await wallet.getTransfers();
        const balance = await wallet.getBalance(wallet.address);
        assert(transfers[0].approvals == '1');
        assert(transfers[0].sent === false);
        assert(balance == '1000');
    });

    it('should send transfer if quorum is reached', async () => {
        const balanceBefore = web3.utils.toBN(await web3.eth.getBalance(accounts[6]));
        await wallet.createTransfer(100, accounts[5], {from: accounts[0]});
        await wallet.approveTransfer(0, {from: accounts[0]});
        await wallet.approveTransfer(0, {from: accounts[1]});
        const balanceAfter = web3.utils.toBN(await web3.eth.getBalance(accounts[6]));
        assert(balanceAfter.sub(balanceBefore).toNumber() === 100);
    });

    it('should NOT approve transfer sender is not approved', async () => {
        await wallet.createTransfer(100, accounts[5], {from: accounts[0]});
        await expectRevert(
            wallet.approveTransfer(0, {from: accounts[4]}),
            'only approver allowed'
        );
    });

    it('should NOT approve transfer if transfer is already sent', async () => {
        await wallet.createTransfer(100, accounts[6], {from: accounts[0]});
        await wallet.approveTransfer(0, {from: accounts[0]});
        await wallet.approveTransfer(0, {from: accounts[1]});
        await expectRevert(
            wallet.approveTransfer(0, {from: accounts[2]}),
            'transfer has already been sent'
        );
    });

    it('should NOT approve transfer twice', async () => {
        await wallet.createTransfer(100, accounts[5], {from: accounts[0]});
        await wallet.approveTransfer(0, {from: accounts[0]});
        await expectRevert(
            wallet.approveTransfer(0, {from: accounts[0]}),
            'cannot approve transfer twice'
        );
    });
});
