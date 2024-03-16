// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "node_modules/@manifoldxyz/creator-core-solidity/contracts/extensions/ERC721/ERC721CreatorExtensionApproveTransfer.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";
import "node_modules/@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "node_modules/@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";

interface IERC6551Registry {
    function account(address implementation, bytes32 salt, uint256 chainId, address tokenContract, uint256 tokenId) external view returns (address account);
}

contract ERC721Soulbound is ERC721CreatorExtensionApproveTransfer {
    IERC20 private molochShareToken;
    IERC6551Registry private erc6551Registry;
    address private implementationAddress;
    bytes32 private salt;
    uint256 private chainId;
    address private nftContract;

    // Mapping to keep track of approved addresses
    mapping(address => bool) private approvedAddresses;

    constructor(IERC20 _molochShareToken, IERC6551Registry _erc6551Registry, address _implementationAddress, bytes32 _salt, uint256 _chainId, address _nftContract) Ownable(msg.sender) {
        molochShareToken = _molochShareToken;
        erc6551Registry = _erc6551Registry;
        implementationAddress = _implementationAddress;
        salt = _salt;
        chainId = _chainId;
        nftContract = _nftContract;
    }

    function approveTransfer(address /* operator */, address from, address /* to */, uint256 tokenId) view external override returns (bool) {
    address nftAccount = erc6551Registry.account(implementationAddress, salt, chainId, nftContract, tokenId);
    uint256 tokenBalance = molochShareToken.balanceOf(nftAccount);

    if (tokenBalance > 0 || approvedAddresses[from]) {
        return true;
    } else {
        revert("Transfer not approved: NFT is soulbound");
    }
}

    // Add or remove addresses from the approved list
    function addApprovedAddress(address _address) external adminRequired {
        approvedAddresses[_address] = true;
    }

    function revokeApprovedAddress(address _address) external adminRequired {
        approvedAddresses[_address] = false;
    }
}