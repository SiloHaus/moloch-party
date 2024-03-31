# SCRIPTS

These Scripts are meant to be used within Hardhat. In order to get them to work, you need to go through and add the correct information: 

Mostly, the information is the contract address of the Minter -- since, these scripts all call functions on that contract.

## capSupply.js
* The Minter has a maxSupply set, and keeps track of mintCount. This is because Manifold Contracts allow you to mint on top of an existing collection, so if you wanted to add a Batch of 69 on top of a collection of 69, you would need that control to be set as a "maxSupply" which can be minted by this extension.
* The capSupply() sets maxSupply == mintCount, effectively freezing the minter from producing more NFTs from those AKORD files.

``` npx hardhat run scripts/capSupply.js --network sepolia ```

## deploy.js
* The constructor allows you to preload some values for the contract:
 * creator = "0xWHATEVER" // This is the Manifold Creator Contract. Extensions build on top of the Manifold Core Contract. You would deploy this contract in Manifold Studio.
 * alchemistressesMolochTreasury = "0xTREASURY" // The purpose of the collection is to raise ETH for this treasury, and also provide Inventory for the DAO to bring from the LazyMint into a DAO owned Sudoswap LP. 
 * alchemixOpMultisig = "0xWHATEVER" //  This address is an ETH split, which directs toward the Alchemix OP Multisig, to repay the grant. You could use this to pay an Artist.

``` npx hardhat run scripts/deploy.js --network sepolia ```

## mint.js
* This Mint is simple. You call it, and pay the ETH and get an NFT.
* alchemistressesMolochTreasury also gets a free mint here.

``` npx hardhat run scripts/mint.js --network sepolia ```

## mintBatch.js
* Batch Mint Function was included as a convenience for the DAO Treasury // Can only be used by alchemistressesMolochTreasury.
* The contract is written so that alchemistressesMolochTreasury has free mints, and can pull 10 at a time into the DAO Traesury.
* When Sudoswap Pools are there, these can be sold by the DAO in an auction, or they can be supply side LP for a Sudo Pool.

``` npx hardhat run scripts/mintBatch.js --network sepolia ```

## setBaseURI.js
* setBaseURI is a function as mentioned above -- you set the Base URI, and then as each TokenID is minted, the TokenURI becomes ([BaseURI]/[tokenId].json)
* The TokenURI is the URL where the NFT Metadata is stored on Arweave. NFTs metadata is retrieved from this JSON, and within the JSON, there is an IMAGE Tag, which has another Arweave address for the actual Image.
* A nuance of these contracts is that Manifold allows tokenId to build over multiple batches, which means if you already have 69 NFTs, you need to start your Arweave for a new batch at [BaseURI]/70.json

``` npx hardhat run scripts/setBaseURI.js --network sepolia ```
  
## setMintPrice.js
* This script uses ethers, and allows you to set a Mint price denominated in ETH. It will automatically convert it to wei.
* Example: 0.05 ETH

``` npx hardhat run scripts/setMintPrice.js --network sepolia ```
  
## withdraw.js
* alchemistressesMolochTreasury receives 97.5% of the ETH on Withdraw
* alchemixOpMultisig receives 2.5% of the ETH on Withdraw
* This is a public function, so anyone can execute it.

``` npx hardhat run scripts/withdraw.js --network sepolia ```