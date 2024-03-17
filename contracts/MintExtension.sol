// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract ERC721LazyMint is AdminControl, ICreatorExtensionTokenURI {
    using Strings for uint256;

    address private _creator; // Manifold Contract
    string private _baseURI; // Sources URI from Akord
    uint256 private _tokenCount;
    uint256 public _maxTokens = 69; // Set to be 69, can be reduced with capSupply()
    uint256 private _mintPrice;

    address payable private alchemistressesMolochTreasury; // DAO RQ Treasury
    address payable private alchemixOpMultisig; // ALCX OP Multisig
    uint256 private constant primaryShare = 975; // 97.5%
    uint256 private constant totalShare = 1000; // Total shares represented as 100%

    // Event declarations used to provide information to the Squarespace Frontend
    event TokenMinted(uint256 totalTokenCount);
    event MaxTokensUpdated(uint256 newMaxTokens); // Event declaration for updating max tokens
    event SoldOut();
 
    constructor(
        address creator, 
        address payable _alchemistressesMolochTreasury, 
        address payable _alchemixOpMultisig
    ) Ownable(msg.sender) {
        _creator = creator;
        alchemistressesMolochTreasury = _alchemistressesMolochTreasury;
        alchemixOpMultisig = _alchemixOpMultisig;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || AdminControl.supportsInterface(interfaceId) || super.supportsInterface(interfaceId);
    }

    // Free Mint for alchemistressesMolochTreasury -- Everyone else has to pay _mintPrice.

    function mint() public payable {
        require(_tokenCount < _maxTokens, "Max token limit reached");
        if (msg.sender != alchemistressesMolochTreasury) {
            require(msg.value >= _mintPrice, "Insufficient payment for minting");
        }
        IERC721CreatorCore(_creator).mintExtension(msg.sender);
        _tokenCount++;
        emit TokenMinted(_tokenCount); // Emit the event after minting
        if (_tokenCount >= _maxTokens) {
            emit SoldOut();
        }
    }

    // Free batch of 10 Mints for alchemistressesMolochTreasury -- Nobody else can use this function.
    // If there are not enough mints left for 10, it will accept less.

    function mintBatchLimited() public payable {
        require(msg.sender == alchemistressesMolochTreasury, "Caller is not authorized");
        uint256 maxBatchSize = 10; // Adjusted to 10 as an example
        uint256 remainingTokens = _maxTokens - _tokenCount;
        uint256 actualBatchSize = remainingTokens < maxBatchSize ? remainingTokens : maxBatchSize;

        require(actualBatchSize > 0, "Max token limit reached");
        for (uint256 i = 0; i < actualBatchSize; i++) {
            IERC721CreatorCore(_creator).mintExtension(msg.sender);
        }
        _tokenCount += actualBatchSize;
        emit TokenMinted(_tokenCount); // Emit the event after batch minting
        if (_tokenCount >= _maxTokens) {
            emit SoldOut();
        }
    }

    // setBaseURI after deploying
    function setBaseURI(string memory baseURI) public adminRequired {
        _baseURI = baseURI;
    }

    function currentTokenCount() public view returns (uint256) {
        return _tokenCount;
    }

    // setMintPrice after deploying
    function setMintPrice(uint256 price) public adminRequired {
        _mintPrice = price;
    }

    function tokenURI(address creator, uint256 tokenId) external view override returns (string memory) {
        require(creator == _creator, "Invalid token");
        return string(abi.encodePacked(_baseURI, tokenId.toString(), ".json"));
    }

   // Cap the supply at any moment -- if there is no demand for the artwork, you can shut it down.
    function capSupply() public adminRequired {
        _maxTokens = _tokenCount;
        emit MaxTokensUpdated(_maxTokens);
        emit SoldOut();
    }

    // Withdraw function can be called by anyone. It sends 97.5% to the DAO Treasury, and the remainder to the OpMultisig.
    function withdraw() public {
        uint256 totalAmount = address(this).balance;
        uint256 primaryAmount = (totalAmount * primaryShare) / totalShare;
        uint256 secondaryAmount = totalAmount - primaryAmount;
        (bool successPrimary, ) = alchemistressesMolochTreasury.call{value: primaryAmount}("");
        require(successPrimary, "Failed to send Ether to alchemistressesMolochTreasury");
        (bool successSecondary, ) = alchemixOpMultisig.call{value: secondaryAmount}("");
        require(successSecondary, "Failed to send Ether to alchemixOpMultisig");
    }
}