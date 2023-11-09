const Wallet = artifacts.require("Wallet");

module.exports = async function(deployer, _network, addresses) {
  await deployer.deploy(Wallet, [accounts[0], accounts[1], accounts[2]], 2);
  const wallet = await Wallet.deployed();
  web3.eth.sendTransactions({from: accounts[0], to: wallet.address, value: 1000});
};
