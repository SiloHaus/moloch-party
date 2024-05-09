// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/*
OBJECTIVE: 

TierII.sol allows custom artwork to be minted within a sequential TokenID series for an existing Manifold Collection.

The Manifold Creator Core Contract will mint sequential TokenIDs from whatever Extension calls mint() next, so TierII and TierI run in parallel. 
If TokenID 6 is a mintComm(), then the metadata for mint() that would have been tokenID 6 on Akord is passed over.

MolochParty.sol governs supply by setting a cap on the number of tokens minted per campaign, the sum of both Tiers.

SETUP:

PartyFactory.sol is Admin, and sets these functions:

1. setBaseURI()
2. setMolochPartyAddress()
3. registerManifoldExtension()

ARCHITECTURE: 

A Child Instance of TierII.sol is created by PartyFactory.sol for each new campaign.

* TierII.sol is a Child contract of PartyFactory.sol
* TierII.sol is a Delegate contract of MolochFactory.sol

EVENTS: 

Events Emitted from this contract are Redundant.

*/

contract TierII is AdminControl, ICreatorExtensionTokenURI {
    using Strings for uint256;

    address private _creator; // Manifold Parent Contract
    string private _baseURI; // BaseURI sourced from Akord, pointing to commission-specific metadata
    address private molochParty; // Address of the MolochParty contract
    uint256[] private mintedTokenIds; // Array to store minted TokenIDs

    event TokenMinted(uint256 tokenId); //tap_to_emit_tokenIds

    constructor(address creator) Ownable(msg.sender) {
        _creator = creator;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || AdminControl.supportsInterface(interfaceId) || super.supportsInterface(interfaceId);
    }

    // setBaseURI()
    function setBaseURI(string memory baseURI) external adminRequired {
        _baseURI = baseURI;
    }

    // setMolochPartyAddress()
    function setMolochPartyAddress(address _molochParty) external adminRequired {
        molochParty = _molochParty;
    }

    // mintComm() called by MolochParty.sol for TierII Contribution.
    function mintComm(address recipient) external {
        require(msg.sender == molochParty, "Caller is not authorized MolochParty");
        uint256 tokenId = IERC721CreatorCore(_creator).mintExtension(recipient);
        mintedTokenIds.push(tokenId); // Track the minted TokenID
        emit TokenMinted(tokenId);
    }

    // Function to retrieve all minted TokenIDs
    function getMintedTokenIds() external view returns (uint256[] memory) {
        return mintedTokenIds;
    }

    // Akord URI Setup
    function tokenURI(address creator, uint256 tokenId) external view override returns (string memory) {
        require(creator == _creator, "Invalid token or creator");
        return string(abi.encodePacked(_baseURI, tokenId.toString(), ".json"));
    }
}
