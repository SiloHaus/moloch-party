# CONTRACTS

## CommExtension.sol

A Commission Extension for a Manifold Collection, which allows for Minters to order custom pieces which exist with the same contract.
// Create Commissions MetaData Folder

## DAOInventory.sol

A distribution for the existing 14 NFTs in the DAO Treasury.

## MintExtension.sol

A Mint Extension for a Manifold PFP Project.

## PreTransferHook.sol

A Manifold Extension which checks that a NFT still holds its Moloch Share before Transfer.

The Owner of this contract can use approveAddress() or revokeAddress().

To activate this contract, deploy it, and then go to the Write as Proxy section on OP Etherscan, for your Manifold Contract. Then, set the deployed address in setApproveTransfer().
Your Manifold contract will automatically set the pre-transfer hook to enabled.

To remove, enter 0x0 in setApproveTransfer().


1) Set the variables in the deploy.js file for the Pre-Transfer Hook Extension. 
2) Deploy Pre-Transfer Hook Extension to protect against selling NFTs after burning shares
3) Register the Pre-Transfer Hook Extension as an Extension in Manifold Studio
4) Enter the contract address into setApproveTransfer() in your Manifold NFT Contract Write as Proxy section on OP Etherscan
5) addApprovedAddress() for necessary sales and treasury addresses in OP Etherscan for your Extension Contract

**[Vulnerability]**: If you have all of your ETH in the RQ Treasury, and then only one person uses the [RDF Claim App](https://silohaus.github.io/silo-nft-dao-admin/#/molochv3/0xa/0x912aab5913023d20a5dcd17160e6954528433a7f/activate), then that person will have the only share, and their share will be the entire treasury. So, it's best that you wait to have more people use the claim app before transfering ETH to the RQ Treasury.

It's best to do a batch claim, or individual claims rather than lose ETH due to people not claiming after getting their NFTs. The ETH lost in this case, is part of everyone's equity, due to the imbalance of ETH to claimed shares.

The Shaman is an admin contract, which you can find here, at the bottom of the DAO Page.
![Screenshot 2024-02-03 at 12 29 48 AM](https://github.com/SiloHaus/manifold-approveTransfer/assets/54530373/5ebaa9d1-34d6-4be1-833b-fb212dc1e1ba)

The Shaman has public claim functions accessible via Etherscan: 
![Screenshot 2024-02-03 at 12 30 49 AM](https://github.com/SiloHaus/manifold-approveTransfer/assets/54530373/f51e6bdb-520c-4f8a-8b06-3ebbe95faaa1)

Enter the tokenID for each NFT you'd like to claim on behalf of, if you have a situation where there is more ETH in the Treasury, and some shares have not yet been claimed by people who have bought into the DAO.

10) Transfer Funds from Manager Safe into Moloch Treasury
11) Give Perms | Ownership of Manifold Contract and Extension Contract to DAO.

## CAUTIONS: 

You'll notice that some things don't work in the contract:

1) The bool for setApproveTransferExtension doesn't work on the Manifold Contract. This is because it's automatically turned on.
2) The ability to setApproveTransfer and Bool doesn't work from the contract extension. This is because only the Admin of the Manifold contract can use these functions.

You also need to be aware of your Permissions moving forward:

1) Has your Deployer Address given permissions for Manifold over to the DAO?
2) Has your Deployer Address revoked its own permissions for the Manifold Contract?
3) Has your Deployer Address given Ownership of ApproveTransferEx.Sol over to the DAO?
4) Which addresses have been added to the approveAddress WL?

## EXTENSION INSTRUCTIONS:

1) npx hardhat compile
2) npx hardhat run scripts/deploy.js --network optimism
3) npx hardhat verify --network optimism /*deployed extension contract*/ /*"molochShareAddress"*/ "0x000000006551c19487814612e58FE06813775758" "0x55266d75D1a14E4572138116aF39863Ed6596E7F" "0x0000000000000000000000000000000000000000000000000000000000000000" "10" /*"nftContract from Manifold"*/

## MOLOCH RDF | TOOLS

* [RDF Summoner on OP | BASE](https://silohaus.github.io/silo-rdf-summoner/)
* [RDF Admin App](https://silohaus.github.io/silo-nft-dao-admin/)
* [RDF Activation](https://silohaus.github.io/silo-nft-dao-admin/#/molochv3/0xa/0x912aab5913023d20a5dcd17160e6954528433a7f/activate)
* [Hashlips | Generative Traits Art Engine](https://github.com/HashLips/hashlips_art_engine)
* [Splits.org](https://app.splits.org/accounts/0xEBae01221b1C1F8c8694967A16389893C04b381F/?chainId=10)

## REFERENCE

* [Tokenbound Accounts](https://docs.tokenbound.org/)
* [Manifold TokenURI Documentation](https://docs.manifold.xyz/v/manifold-for-developers/smart-contracts/manifold-creator/contracts/extensions/extensions-functions#setbasetokenuriextension)
* [Manifold Developer Documentation](https://docs.manifold.xyz/v/manifold-for-developers/smart-contracts/manifold-creator/contracts/extensions/extensions-functions)
* [AKORD Documentation](https://docs.akord.com/nfts/storing-nft-assets-on-arweave/generating-manifests-in-akord-vaults)
* [OpenSea Metadata Standards](https://docs.opensea.io/docs/metadata-standards)
