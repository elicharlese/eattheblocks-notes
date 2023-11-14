import React, { useState, useEffect } from 'react';
import { getWeb3, getContracts } from './utils.js'
import App from './app.js'

function LoadingContainer() {
  const [web3, setWeb3] = useState(undefined);
  const [accounts, setAccounts] = useState([]);
  const [contracts, setContracts] = useState(undefined);

  useEffect(() => {
    const init = async () => {
      const web3 = await getWeb3();
      const contracts = await getContracts(web3);
      const accounts = await 
    }
  }, []);

  const isReady = () => {
    return (
      typeof web3 !== 'undefined'
      && typeof contracts !== 'undefined'
      && accounts.length > 0
    );
  }

  if(!isReady()) {
    return <div>Loading...</div>;
  }

  return (
    <App
      web3={web3}
      accounts={accounts}
      contracts={contracts}
    />
  );
}

export default loadingContainer;
