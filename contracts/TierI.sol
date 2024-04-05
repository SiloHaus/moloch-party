// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/*
OBJECTIVE: 

TierI.sol contains mint(), which is a gacha | lazymint for Manifold.
TierI.sol contains mintBatch(), mints all unsold Inventory to the DAO owned Treasury for Sudo LP.

MolochParty.sol governs supply by setting a cap on the number of tokens minted per campaign, the sum of both Tiers.


SETUP:

PartyFactory.sol is Admin, and sets these functions:

1. setBaseURI()
2. setMolochPartyAddress()
3. registerManifoldExtension()

ARCHITECTURE: 

A Child Instance of TierI.sol is created by PartyFactory.sol for each new campaign.

* TierI.sol is a Child contract of PartyFactory.sol
* TierI.sol is a Delegate contract of MolochFactory.sol

EVENTS: 

Events Emitted from this contract are Redundant.

*/

contract TierI is AdminControl, ICreatorExtensionTokenURI {
    using Strings for uint256;

    address private _creator; // Manifold Contract
    string private _baseURI; // Sources URI from Akord
    address private molochParty; // MolochParty Contract Address

    event TokenMinted(uint256 tokenId); //tap_to_emit_tokenIds
 
    constructor(address creator) Ownable(msg.sender) {
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

    // mintBatch() called by MolochParty.sol to mint remaining supply at end of Campaign.
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
