import { ThirdwebSDK } from "@thirdweb-dev/sdk";

const sdk = new ThirdwebSDK("mumbai");
const contract = sdk.getNFTDrop("0x53baA49a65e5a6c0E89ae1Eb15212Bd16bD1b90A");

// Get NFT Balance
const walletAddress = "0x53baA49a65e5a6c0E89ae1Eb15212Bd16bD1b90A"; // Example address
const balance = await contract.balanceOf(walletAddress);
console.log("My NFT balance is: ", balance.toNumber());

// Get all unclaimed NFT's
const unclaimedNFTs = await contract.getAllUnclaimed();
// const firstUnclaimedNFT = unclaimedNFTs[0].name;
console.log("My unclaimed NFT's are: ", unclaimedNFTs.map(item => {
    return item.name;
}));

// Get a single NFT metadata
const tokenId = 0;
const nft = await contract.get(tokenId);
console.log("Metadata of tokenId 0: ", nft);
