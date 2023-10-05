# Deployig using Hardhat

## Hardhat Starter Kit

![Alt text](image-74.png)
![Alt text](image-75.png)
![Alt text](image-76.png)
![Alt text](image-77.png)
![Alt text](image-78.png)
![Alt text](image-79.png)

Import all dependancies
`yarn` or `yarn install` or `npm install`
![Alt text](image-80.png)

Starts a fake blockchain on our computer
`npm hardhat node`
![Alt text](image-82.png)

It runs through all the deploy scripts
![Alt text](image-83.png)

It creates mock contracts
![Alt text](image-84.png)

Runs through the scripts and displays the print outputs
![Alt text](image-85.png)
![Alt text](image-86.png)

We can test everyhting much quicker
![Alt text](image-87.png)
![Alt text](image-88.png)

## Deploying to a mainnet and not a testnet

![Alt text](image-89.png)
![Alt text](image-90.png)

This is an example env
![Alt text](image-91.png)
![Alt text](image-92.png)

Remember to add the '0x' prefix
![Alt text](image-93.png)

For your MNUEMONIC
![Alt text](image-94.png)

Comment out the parts you don't want to and then leave the rest
![Alt text](image-95.png)

## Deploying

![Alt text](image-96.png)
![Alt text](image-97.png)

`npx hardhat test`
![Alt text](image-98.png)

For Polygon go into hardhat config and change the following
![Alt text](image-99.png)

![Alt text](image-100.png)
![Alt text](image-101.png)

We also have to update the helper configuration
![Alt text](image-102.png)
![Alt text](image-103.png)
