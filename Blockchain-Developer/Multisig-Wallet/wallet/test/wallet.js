const Wallet = artifacts.require('Wallet');

contract('Wallet', (accounts) => {
    let wallet;
    beforeEach(async () => {
        wallet = await Wallet.new([accounts[0], accounts[1], accounts[2]], 2); // we need to provide an array of approvers and the quroum (min # of approvers)
        // accounts up to 10 prefilled test wallets provided by truffle
        await web3.eth.sendTransaction({from: account[0], to: wallet.address, value: 1000});
        // await pauses the function in order to await the prosed value so that it is resolved and usable.
        // we are on an asynchronous timelapse because we are manipulating the layers of events triggered on the single thread.
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
});
