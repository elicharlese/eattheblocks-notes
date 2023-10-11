// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC721Base.sol";
import "@thirdweb-dev/contracts/extension/DelayedReveal.sol";

contract MyNewNFT is ERC721Base, DelayedReveal {
    address public deployer;

    constructor(
        address _defaultAdmin,
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    )
        ERC721Base(
            _defaultAdmin,
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps
        )
    {
        deployer = msg.sender;
    }

    function mintDelayedRevealNFTP(
        address to,
        string memory beforeRevealURI,
        bytes memory encryptedPostRevealURI
    ) public {
        uint256 tokenId = nextTokenIdToMint();
        _setEncryptedData(tokenId, encryptedPostRevealURI);
        mintTo(to, beforeRevealURI);
    }

    mapping(uint256 => string) private postRevealURI;

    function reveal(uint256 tokenId, bytes calldata key)
        external
        override
        returns (string memory revealedURI)
    {
        revealedURI = getRevealURI(tokenId, key);

        // delete encryptedData(tokenId);

        postRevealURI[tokenId] = revealedURI;
    }

    function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
    {
        if (bytes(postRevealURI[tokenId]).length > 0) {
            return postRevealURI[tokenId];
        }

        return super.tokenURI(tokenId);
    }
}

