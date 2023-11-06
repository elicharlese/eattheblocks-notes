import Web3 from 'web3';
import Wallet from './contracts/Wallet.json';

// With our web3 object we have a connection to the Ethereum blockchain
const getWeb3 = () => {
  return new Web3('https://localhost:9545');
};

const getWallet = async web3 => {
  const networkId = await web3.eth.net.getId();
  // Better name than deployedNetwork
  const contractDeployment = Wallet.networks[networkId];
  return new web3.eth.Contract(
    Wallet.abi,
    contractDeployment && contractDeployment.address
  );
};

export { getWeb3, getWallet }
