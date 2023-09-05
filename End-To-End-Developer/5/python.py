from thirdweb import ThirdwebSDK

# You can customize this to a supported netweo kor your own RPC URL
network = "mumbai"

# Now we can create a new instance of the SDK
sdk = ThirdwebSDK(network)

# If you want to send transactions, you can instantiate the SDK with a private key instead:
    # sdk = ThirdwebSDK.from_private_key(PRIVATE_KEY, network)
    
contract = sdk.get_nft_drop("0x000000000000000000")

balance = contract.balance_of("0x000000000000000000")
print("My NFT balance: ", balance)


total_unclaimed = contract.total_unclaimed_supply()
print("Total unclaimed NFTs: ", total_unclaimed)

nft = contract.get(1)
print("Metadata of NFT 1:", nft)
