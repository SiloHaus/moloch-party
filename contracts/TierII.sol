// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/*
Steps for setting up the TierII extension:
1. Register the extension with the Manifold XYZ core contract to ensure it's recognized within the ecosystem.
2. Utilize setBaseURI to specify the metadata location, integrating with Akord for decentralized storage.
3. Use setMolochPartyAddress to connect this extension with the MolochParty contract, enabling controlled minting.
*/

abstract contract TierII is AdminControl, ICreatorExtensionTokenURI {
    using Strings for uint256;

    address private _creator; // Manifold Parent Contract
    string private _baseURI; // BaseURI sourced from Akord, pointing to commission-specific metadata
    address private molochParty; // Address of the MolochParty contract

    event TokenMinted(uint256 tokenId);

    constructor(address creator) {
        _creator = creator;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || AdminControl.supportsInterface(interfaceId) || super.supportsInterface(interfaceId);
    }

    // Set the MolochParty contract address; only an admin can set this
    function setMolochPartyAddress(address _molochParty) external adminRequired {
        molochParty = _molochParty;
    }

    // Mint commissioned work; only callable by MolochParty
    function mintComm(address recipient) external {
        require(msg.sender == molochParty, "Caller is not authorized MolochParty");
        uint256 tokenId = IERC721CreatorCore(_creator).mintExtension(recipient);
        emit TokenMinted(tokenId);
    }

    // Set BaseURI for commissioned works metadata
    function setBaseURI(string memory baseURI) external adminRequired {
        _baseURI = baseURI;
    }

    // Return tokenURI for a given tokenId, concatenating the baseURI with the token's ID
    function tokenURI(address creator, uint256 tokenId) external view override returns (string memory) {
        require(creator == _creator, "Invalid token or creator");
        return string(abi.encodePacked(_baseURI, tokenId.toString(), ".json"));
    }
}
