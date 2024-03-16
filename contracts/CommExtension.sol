// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract CommExtension is AdminControl, ICreatorExtensionTokenURI {
    using Strings for uint256;

    address private _creator; // Manifold Parent Contract
    string private _baseURI; // Sources BaseURI from Akord | underConstructionMeme.png
    uint256 private _tokenCount; // This counts how many have been Minted.
    uint256 public _maxComms = 10; // How many commissions can the artist handle for this campaign?
    uint256 private _commPrice = 0.5 ether; // What is the final price paid by the commissioner?

    address payable private splitAddress; // Uses app.splits.org to create a payment split & inserts that split into Constructor.
    
    event TokenMinted(uint256 totalTokenCount);
    event MaxTokensUpdated(uint256 newMaxTokens); // Event declaration for updating max tokens
    event SoldOut();

// These addresses in the constructor are established in deployment.

    constructor(
        address creator, 
        address payable _splitAddress
    ) Ownable(msg.sender) {
        _creator = creator;
        splitAddress = _splitAddress; // 0xEBae01221b1C1F8c8694967A16389893C04b381F Split Address on Optimism for Alchemix Comm. 
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || AdminControl.supportsInterface(interfaceId) || super.supportsInterface(interfaceId);
    }

     function mintComm() public payable {
        require(_tokenCount < _maxComms, "Artist Cannot Accept any more Commissions!");
        require(msg.value >= _commPrice, "Artist Needs Food, Badly!");
        IERC721CreatorCore(_creator).mintExtension(msg.sender);
        _tokenCount++;
        
        // This increments the TokenID for the parent Manifold Contract.

        emit TokenMinted(_tokenCount); // Emit the event after minting so the Frontend can pick up status.
        if (_tokenCount >= _maxComms) {
            emit SoldOut();
        }
    }

/*

setBaseURI is the Akord | Arweave Manifest URL which is the prefix to the tokenID.

This project uses two separate Manifold Extensions, each with their own Arweave folders:

* PFPExtension.sol -- The Metadata for this Extension is pre-generated.
* CommExtension.sol -- The Metadata for this Extension has a placeholder image, and is updated after the commissions are completed.

Both Extensions are deployed, and point to the same Manifold Parent Contract. 

Each Extension has a mint() with their own unique BaseURI, Price, and Max Supply.
 
When each Extension calles mint(), the Manifold Parent Contract increments the TokenID for the NFT Contract. This means that the next tokenID increment will either be from the PFPExtension | CommExtension. 

Meaning that the actual NFT Collection is formed from two existing possible pools of NFTs, the PFP collection, and the Commissions. 

If TokenID 10 is from the CommExtension, then, the JSON File that WOULD HAVE BEEN TokenID 10 from PFPExtension, will never be.

*/

    function setBaseURI(string memory baseURI) public adminRequired {
        _baseURI = baseURI;
    }

    function currentTokenCount() public view returns (uint256) {
        return _tokenCount;
    }

    function tokenURI(address creator, uint256 tokenId) external view override returns (string memory) {
        require(creator == _creator, "Invalid token");
        return string(abi.encodePacked(_baseURI, tokenId.toString(), ".json"));
    }

   // Function to cap the current supply

    function capSupply() public adminRequired {
        _maxComms = _tokenCount;
        emit MaxTokensUpdated(_maxComms);
        emit SoldOut();
    }

      function withdraw() public {
        uint256 totalAmount = address(this).balance;
        
        // Send the entire balance to the splitAddress
        (bool success, ) = splitAddress.call{value: totalAmount}("");
        require(success, "Failed to send Ether");
    }
}