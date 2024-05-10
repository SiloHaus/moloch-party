// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// TIERI is for Minting Individual NFTs, or Minting the Remainder of the supply at the end of the Campaign.

contract TierI is AdminControl, ICreatorExtensionTokenURI {
    using Strings for uint256;

    address private _creator; // Manifold Contract
    string private _baseURI; // Sources URI from Akord
    address private molochParty; // Moloch Party Campaign Contract Address

// EVENTS
    event TokenMinted(uint256 tokenId);
 
// CONSTRUCTOR
    constructor(address creator) Ownable(msg.sender) {
        _creator = creator;
    }

// CONFIGURATION
    // setBaseURI()
    function setBaseURI(string memory baseURI) external adminRequired {
        _baseURI = baseURI;
    }

    // Akord URI Setup
    function tokenURI(address creator, uint256 tokenId) external view override returns (string memory) {
        require(creator == _creator, "Invalid token");
        return string(abi.encodePacked(_baseURI, tokenId.toString(), ".json"));
    }

    // setMolochPartyAddress()
    function setMolochPartyAddress(address _molochParty) external adminRequired {
        molochParty = _molochParty;
    }

    // registerManifoldExtension()
    function registerManifoldExtension() external adminRequired {
        ICreatorCore(_creator).registerExtension(address(this), _baseURI);
    }

    // Manifold Function
    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || AdminControl.supportsInterface(interfaceId) || super.supportsInterface(interfaceId);
    }

// MINT
    // mint()
    function mint(address recipient) external {
        require(msg.sender == molochParty, "Caller is not the MolochParty contract");
        uint256 tokenId = IERC721CreatorCore(_creator).mintExtension(recipient);
        emit TokenMinted(tokenId);
    }

    // mintBatch() | Mint remaining supply at end of Campaign.
    function mintBatch(address recipient, uint256 remaining) external {
        require(msg.sender == molochParty, "Caller is not the MolochParty contract");
        for (uint256 i = 0; i < remaining; i++) {
            uint256 tokenId = IERC721CreatorCore(_creator).mintExtension(recipient);
            emit TokenMinted(tokenId);
        }
    }
}
