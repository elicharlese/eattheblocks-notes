import Web3 from 'web3';
import Wallet from './contracts/Wallet.json';

// With our web3 object we have a connection to the Ethereum blockchain
const getWeb3 = () => {
  return new Promise((resolve, reject) => {
    window.addEventListener('load', async () => {
      if(window.ethereum) {
        const web3 = new Web3(window.ethereum);
        try {
          await window.ethereum.enable();
          resolve(web3);
        } catch(error) {
          reject(error);
        }
      } else if(window.web3) {
        resolve(window.web3);
      } else {
        reject('Must install MetaMask');
      }
    });
  });
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
