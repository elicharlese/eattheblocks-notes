import logo from './logo.svg';
import './App.css';
import React, { useEffect, useState } from 'react';
import { getWeb3, getWallet } from './utils.js';
import Header from './Header.js';
import NewTransfer from './NewTransfer.js';
import TransferList from './TransferList.js';

function App() {
  const [web3, setWeb3] = useState(undefined);
  const [accounts, setAccounts] = useState(undefined);
  const [wallet, setWallet] = useState(undefined);
  const [approvers, setApprovers] = useState(undefined);
  const [quorum, setQuorum] = useState(undefined);
  const [transfer, setTransfers] = useState([]);

  useEffect(() => {
    const init = async () => {
      /* Storing the variables */
      const web3 = getWeb3();
      const accounts = await web3.eth.getAccounts();
      const wallet = await getWallet(web3);
      /* Accessing the smart contract methods */
      const approvers = await wallet.methods.getApprovers().call();
      const quorum = await wallet.methods.quorum().call();
      const tranfers = await wallet.methods.getTransfers().call();
      /* Changing the state */
      setWeb3(web3);
      setAccounts(accounts);
      setWallet(wallet);
      setApprovers(approvers);
      setQuorum(quorum);
      setTransfers(transfers);
    };
    init();
  }, []);

  const createTransfer = transfer => {
    wallet.methods
      .createTransfer(transfer.amount, transfer.to)
      .send({from: accounts[0]})
  }

  const approveTransfer = transfer => {
    wallet.methods
      .
  }

  if (
    typeof web3 === 'undefined'
    || typeof accounts === 'undefined'
    || typeof wallet === 'undefined'
    || typeof approvers === 'undefined'
    || typeof quorum === 'undefined'
  ) {
    return <div>Loading...</div>
  }
  
  return (
    <div>
      Multisig Dapp
      <Header approvers={approvers} quorum={quorum} />
      <NewTransfer createTransfer={createTransfer} />
      <TransferList transfers={transfers} />
    </div>
  );
}

export default App;
