import { useAddress, useMetamask } from "@thirdweb-dev/react";
import type { NextPage } from "next";
import { Button } from 'antd';
import styles from "../styles/Home.module.css"

const Claim: NextPage = () => {

    const connectMetamask = useMetamask();
    const address = useAddress();

    const handleConnectMetamask = () => {
        connectMetamask();
    };

    return (
        <div className="styles.container">
            {address && (<Button>Connected!</Button>)}
            {!address && (<Button onClick={handleConnectMetamask}>Connect Wallet</Button>)}
            <h3>My wallet address: {address}</h3>
        </div>
    )
};

export default Claim;