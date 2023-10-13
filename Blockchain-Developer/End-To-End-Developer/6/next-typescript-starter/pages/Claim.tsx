import {
    useAddress,
    useMetamask,
    useContractMetadata,
    useContract,
    useClaimedNFTs,
    useOwnedNFTs,
    useClaimNFT,
    useBurnNFT,
    ThirdwebNftMedia
} from "@thirdweb-dev/react";

import type { NextPage } from "next";
import { Button } from 'antd';
import styles from "../styles/Home.module.css"

const Claim: NextPage = () => {

// my wallet address
const address = useAddress();
// connect wallet
const connectMetamask = useMetamask();
// the contract address
const ContractAddress = "0x000000000000000000"
// Instance of the contract
const editionDrop = useContract(ContractAddress); // useEditionDrop() is depreciated, useEditionDrop(ContractAddress) will be replaced by useContract(ContractAddress)
// Get contract metadata
const {
    data: contractMetadata,
    isLoading: isLoadingContractMetadata,
    error: metadataError
} = useContractMetadata(ContractAddress);

// Show amount of claimed NFTs (beta)
const {
    mutate: claimNft,
    isLoading: isClaiming,
    error: claimingError
} = useClaimNFT(editionDrop);

    const { data: claimedNFTs } = useClaimedNFTs{ editionDrop, { start: 0, count: 100 }};
    const { data: ownedNFTs } = useOwnedNFTs(editionDrop, address);

// Set claim phase
async function setClaimPhase() {
    const presaleStartTime = new Date();
    const publicSaleStartTime = new Date(Date.now() + 10 * 1000); // 10 seconds from now
    const claimConditions = [
        {
            startTime: presaleStartTime, // start the presale now
            maxQuantity: 'unlimited', // limit how many mints for this presale
            price: 0.01, // presale price
            // snapshot: ['0x...', '0x...'], // limit minting to only certain addresses
            snapshot: false, // don't take a snapshot of the minted NFTs
        },
        {
            startTime: publicSaleStartTime, // 24hr after presale, start public sale
            price: 0.00 // public sale price
        }
    ];

    const tokenId = 2;
    await editionDrop.claimedConditions.set(tokenId, claimConditions);

    alert("New phase set")
}

async function claimNFT() {
    const tokenId = 2; // the id of the NFT you want to claim
    const qty = 1; // how many NFTs you want to claim
    if (!address) {
        connectMetamask();
        return;
    }
    try {
        const tx = await editionDrop?.claimTo(address, tokenId, qty);
        const reciept = tx?.receipt;
        console.log("NFT claim reciept: ", reciept);
        alert("NFT claim successful")
    }
    catch(e) {
        alert("NFT claim unsuccessful");
        console.log(e);
    }
}


//======================================== Rendered Content ============================================

    const handleConnectMetamask = () => {
        connectMetamask();
    };

return (
    <div className="styles.container">
        {address && <Button>Connected!</Button>}
        {!address && (
        <Button onClick={handleConnectMetamask}>Connect Wallet</Button>
        )}
        <h3>My wallet address: {address}</h3>
        <div>Contract name: {contractMetadata?.name}</div>
            <div>Contract description: {contractMetadata?.description}</div>
            <img src={contractMetadata?.image} style={{ marginTop: 20, width: 250, height: 200 }} />
            <Button onClick={async () => {
                const owned = await editionDrop?.getOwned(address);
                let qty = 0
                owned?.map(item => {
                    qty = item.quantityOwned.toNumber() + qty;
                    return qty;
                });
                console.log("I own %s NFTs", qty)
            }}>Console.log owned</Button>
        <Button onClick={claimNFT} style={{ marginTop: 20 }}>Claim NFT</Button>
        <Button onClick={setClaimPhase} style={{ marginTop: 20 }}>Set Phase</Button>
        <Button onClick={async () => {
            const tokenId = 1;
            const amount = 1;
            try {
                const result = await editionDrop?.burnTokens(tokenId, amount);
                alert("Burn successful")
            } catch(e) {
                console.log(e)
                alert("Burn unsuccessful")
            }
        }} style={{ marginTop: 20 }}>Burn NFT</Button>

            {claimedNFTs && claimedNFTs?.length > 0 && (
                <div>
                    {claimedNFTs.map((nft: any) => (
                        <div key={nft?.metadata?.id?.toString()}>
                            <img src={nft?.image} style={{ width: 250, height: 200 }} />
                            <h3>{nft?.supply?.toNumber()} { nft?.metadata?.name} claimed</h3>
                        </div>
                    ))}
                </div>
            )}

            {ownedNFTs && ownedNFTs?.length > 0 && (
                <div className={styles.cards}>
                    {ownedNFTs.map((nft: any) => (
                        <div key={nft?.metadata?.id?.toString()} className={styles.cards}>
                            <h1>{nft?.quantityOwned?.toNumber()} { nft?.metadata?.name} claimed</h1>
                            <ThirdwebNftMedia metadata={nft?.metadata} className={styles.image}/>
                        </div>
                    ))}
                </div>
            )}
    </div>
);

export default Claim;