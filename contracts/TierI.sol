// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/*
SETUP:
1. Register TierI extension with Manifold.
2. setBaseURI() pointing to an Akord.
3. setMolochPartyAddress().
*/

abstract contract TierI is AdminControl, ICreatorExtensionTokenURI {
    using Strings for uint256;

    address private _creator; // Manifold Contract
    string private _baseURI; // Sources URI from Akord
    address private molochParty; // MolochParty Contract Address

    event TokenMinted(uint256 tokenId); // Used by Frontend with Event Listener, to update remaining NFTs to be Minted.
 
    constructor(address creator) {
        _creator = creator;
    }

    // setBaseURI()
    function setBaseURI(string memory baseURI) external adminRequired {
        _baseURI = baseURI;
    }

    // setMolochPartyAddress()
    function setMolochPartyAddress(address _molochParty) external adminRequired {
        molochParty = _molochParty;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || AdminControl.supportsInterface(interfaceId) || super.supportsInterface(interfaceId);
    }

    // mint() called by MolochParty.sol for TierI Contribution.
    function mint(address recipient) external {
        require(msg.sender == molochParty, "Caller is not the MolochParty contract");
        uint256 tokenId = IERC721CreatorCore(_creator).mintExtension(recipient);
        emit TokenMinted(tokenId);
    }

    // mintBatch() called by MolochParty.sol to deposit mintSupply [all of the rest of the NFTs for that batch of 69 that have not been minted] to molochVault.
    function mintBatch(address recipient, uint256 remaining) external {
        require(msg.sender == molochParty, "Caller is not the MolochParty contract");
        for (uint256 i = 0; i < remaining; i++) {
            uint256 tokenId = IERC721CreatorCore(_creator).mintExtension(recipient);
            emit TokenMinted(tokenId);
        }
    }

    // Akord URI Setup
    function tokenURI(address creator, uint256 tokenId) external view override returns (string memory) {
        require(creator == _creator, "Invalid token");
        return string(abi.encodePacked(_baseURI, tokenId.toString(), ".json"));
    }
}
