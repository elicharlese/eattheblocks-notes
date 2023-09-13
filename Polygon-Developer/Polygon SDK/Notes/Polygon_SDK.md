# Polygon SDK

## Three Layers

In order to interact with the layers we have to make RPC calls.

![Alt text](image.png)
![Alt text](image-1.png)

## Initialization of Plasma Client

- We have the Plasma Client
- We also have the PoS Client
- We use matic.js to use an abstraction layer to build our apps faster.

![Alt text](image-2.png)

- Mumbai is polygons testnet
- Testnet is going to be "mumbai" and the mainnet is "v1"
- Mumbai syncs with Goerli (Ethereum testnet)

### RPC

- Moralis
- Infura
- Alchemy
- Chainstack
- MaticVigil
- QuickNode
- Ankr
- Getblock

### Chainstack

Chainstack is a paid service, you can use it to access historical dataon the blockchain.

- Mapped Tokens, Genesis Contracts (helps to standardize the mapping of tokens across different blockchains)

![Alt text](image-3.png)

## Demo for usage of Plasma and PoS API

![Alt text](image-4.png)

### We will now get the balance using Plasma

![Alt text](image-5.png)

## Asset Bridge

![Alt text](image-6.png)

### Metamask Configuration

![Alt text](image-7.png)
![Alt text](image-8.png)

We go to metamask go to the bottom and select network then click "Add a network"
We will then be able to fill out the details as shown below

### Polygon & Goerli

![Alt text](image-9.png)

### MetaMask Wallet Connect Setup

![Alt text](image-10.png)

There will be a list of the test tokens you will need in order to interact with the smart contracts. You will need to gather the funds from various faucets.

### Wallet Connect Provider

You will need to spin up a create-react-app and then we will be putting in the code in order to interact with the metamask wallet connector.

![Alt text](image-11.png)

```javascript
import WalletConnectProvider from "@maticnetwork/walletconnect-provider";
```

Get the RPC URLS's you can use something like Infura or any other node provider.

![Alt text](image-12.png)

### Transfer Assets Using Polygon PoS & Plasma Bridges

![Alt text](image-13.png)

Bridge: moving assets from the root chain to the child chain

### POS bridge (Deposit & Withdrawal)

![Alt text](image-14.png)
![Alt text](image-15.png)
There is a layer of predicate contracts that hold the tokens while they are being transferred.

![Alt text](image-16.png)

We are going to go to the Ethereum Matic Bridge.
![Alt text](image-17.png)

![Alt text](image-18.png)

![Alt text](image-19.png)

The process for the ERC721 is the same as the ERC20 implementation.

![Alt text](image-20.png)
![Alt text](image-21.png)

We will go over the ERC1155.

![Alt text](image-22.png)
![Alt text](image-23.png)

### Plasma bridge (Deposit & Withdrawal)

![Alt text](image-24.png)
![Alt text](image-25.png)

Restrictions on the child token of a 7-day challenge period. These are the risk-management checkpoints.

![Alt text](image-26.png)
![Alt text](image-27.png)
 The transfers can be done instantly.

![Alt text](image-28.png)
