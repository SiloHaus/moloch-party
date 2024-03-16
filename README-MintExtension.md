# OVERVIEW

OBJECTIVE: Launch an NFT Collection on Manifold, using ERC 6551, Moloch RDF and Squarespace. 

The Manifold LazyMint Extension allows you to host a ["Hashlips" | Generative Traits Collection](https://github.com/HashLips/hashlips_art_engine) on Arweave, and then mint tokens from a website.

At this point, you can follow the tutorial for the [Pre-Transfer Hook Extension and Moloch RDF](https://github.com/SiloHaus/manifold-approveTransfer), and your Manifold NFT Collection on Optimism will have its own DAO Treasury.

In the case of Alchemistresses, 69 of the remaining unminted artpieces produced by Shizzy, have been stored on Arweave. This LazyMinter is intended to release that supply over time as they are purchased. 

Since Alchemistresses is a Moloch DAO, and each membership holds equity within a shared treasury, this LazyMinter is also a way to distribute memberships over time while the unsold Memberships are held in a 'pre-mint reserve'.

## LAUNCH PROCESS: 

1. Complete Artwork | Metadata | Upload to AKORD
2. Create Manifold Contract in Manifold Studio, and secure this contract for deploy.js
3. Download Dependencies
4. DEPLOY script - sepolia
5. Approve Manifold LazyMint Extension Contract in Manifold Studio
6. setMintPrice | setBaseURI
7. Test Mint and mintBatch
8. Setup Squarespace | Test mint with UI and Counters.
9. Setup Manager Gnosis Safe to receive Mint funds before DAO Treasury Exists -- or use RDF now, and create the treasury beforehand.
10. Mainnet Launch.
11. If you haven't read through the [Pre-Transfer Hook Extension and Moloch RDF Guide](https://github.com/SiloHaus/manifold-approveTransfer), do that now.

Your objective is to launch a collection using Manifold contracts, and direct funds into a DAO Treasury -- then activate governance shares.

## AKORD | ARWEAVE

Akord provides permaweb storage. The PNG Files and the JSON Files are stored on AKORD, and there is a Manifest.json file that AKORD produces, which allows for finding file paths. 

The BaseURI which is needed by Manifold, is created from the Manifest path to the JSON Folder: 

BaseURI Example: https://abcdefghijklmnopqrstuvwxyz.arweave.net/ligmaDN42069/JSON/

Manifold BaseURI functions by adding the tokenId to the end of that string, and our contract adds a ".json" file to the end to load the Metadata of each NFT.

* [Manifold TokenURI Documentation](https://docs.manifold.xyz/v/manifold-for-developers/smart-contracts/manifold-creator/contracts/extensions/extensions-functions#setbasetokenuriextension)
* [AKORD Documentation](https://docs.akord.com/nfts/storing-nft-assets-on-arweave/generating-manifests-in-akord-vaults)
* [OpenSea Metadata Standards](https://docs.opensea.io/docs/metadata-standards)

## SCRIPTS

These Scripts are meant to be used within Hardhat. In order to get them to work, you need to go through and add the correct information: 

Mostly, the information is the contract address of the Minter -- since, these scripts all call functions on that contract.

#### capSupply.js
* The Minter has a maxSupply set, and keeps track of mintCount. This is because Manifold Contracts allow you to mint on top of an existing collection, so if you wanted to add a Batch of 69 on top of a collection of 69, you would need that control to be set as a "maxSupply" which can be minted by this extension.
* The capSupply() sets maxSupply == mintCount, effectively freezing the minter from producing more NFTs from those AKORD files.

``` npx hardhat run scripts/capSupply.js --network sepolia ```

#### deploy.js
* The constructor allows you to preload some values for the contract:
 * creator = "0xWHATEVER" // This is the Manifold Creator Contract. Extensions build on top of the Manifold Core Contract. You would deploy this contract in Manifold Studio.
 * alchemistressesMolochTreasury = "0xTREASURY" // The purpose of the collection is to raise ETH for this treasury, and also provide Inventory for the DAO to bring from the LazyMint into a DAO owned Sudoswap LP. 
 * alchemixOpMultisig = "0xWHATEVER" //  This address is an ETH split, which directs toward the Alchemix OP Multisig, to repay the grant. You could use this to pay an Artist.

``` npx hardhat run scripts/deploy.js --network sepolia ```

#### mint.js
* This Mint is simple. You call it, and pay the ETH and get an NFT.
* alchemistressesMolochTreasury also gets a free mint here.

``` npx hardhat run scripts/mint.js --network sepolia ```

#### mintBatch.js
* Batch Mint Function was included as a convenience for the DAO Treasury // Can only be used by alchemistressesMolochTreasury.
* The contract is written so that alchemistressesMolochTreasury has free mints, and can pull 10 at a time into the DAO Traesury.
* When Sudoswap Pools are there, these can be sold by the DAO in an auction, or they can be supply side LP for a Sudo Pool.

``` npx hardhat run scripts/mintBatch.js --network sepolia ```

#### setBaseURI.js
* setBaseURI is a function as mentioned above -- you set the Base URI, and then as each TokenID is minted, the TokenURI becomes ([BaseURI]/[tokenId].json)
* The TokenURI is the URL where the NFT Metadata is stored on Arweave. NFTs metadata is retrieved from this JSON, and within the JSON, there is an IMAGE Tag, which has another Arweave address for the actual Image.
* A nuance of these contracts is that Manifold allows tokenId to build over multiple batches, which means if you already have 69 NFTs, you need to start your Arweave for a new batch at [BaseURI]/70.json

``` npx hardhat run scripts/setBaseURI.js --network sepolia ```
  
#### setMintPrice.js
* This script uses ethers, and allows you to set a Mint price denominated in ETH. It will automatically convert it to wei.
* Example: 0.05 ETH

``` npx hardhat run scripts/setMintPrice.js --network sepolia ```
  
#### withdraw.js
* alchemistressesMolochTreasury receives 97.5% of the ETH on Withdraw
* alchemixOpMultisig receives 2.5% of the ETH on Withdraw
* This is a public function, so anyone can execute it.

``` npx hardhat run scripts/withdraw.js --network sepolia ```

## SQUARESPACE

These will let you modify an existing Squarespace page into a web3 compatible NFT Launch Page. You will need to paste your Manifold Extension | Mint Contract into [mintCount.js] & [mintButton.js]

#### header.js
* If you want to do any ethers.js, you need to paste this into the header of your Squarespace page.  
#### Buttons.html
* This you add as a code on the page, there are <span> ids, which correlate to the scripts below, which you embed.
#### connectButton.js
* Minimalist Connect to Metamask button.
#### mintButton.js
* Calls the mint contract. embed it.   
#### mintCount.js
* mintCount is a script meant to help you see how many have been minted, or if the collection is sold out. embed it.
#### Count.html
* In order to use mintCount.js, you need to add Code for Count.html. This will refer to the embedded mintCount.js.

## MOLOCHv3 TOOL URLS: 

This webpage is a DAO Portal. If you have a Molochv3 DAO, you can find it here:
* https://admin.daohaus.fun/

This activate page is an imperfect URL. Technically, this is the activate page for the Alchemistresses 6551 Membership NFTs:
* https://silohaus.github.io/silo-nft-dao-admin/#/molochv3/0xa/0x912aab5913023d20a5dcd17160e6954528433a7f/activate
* The part "0x912aab5913023d20a5dcd17160e6954528433a7f" is the DAO address for the Alchemistersses. Your DAO address will be different.

This webpage is the RDF Summoner for Optimism: 
* https://silohaus.github.io/silo-rdf-summoner/

Technically, your Moloch v3 DAO Shares are owned by your NFTs, and are held within their [Tokenbound Accounts](https://docs.tokenbound.org/). Which means that you will need to Delegate them to yourself. Fortunately, there is a flow where this happens naturally after the Activate | Claim process. 

You really want your people to go MINT -> ACTIVATE | CLAIM -> DELEGATE -- and then they can move forward with proposals using the Moloch v3 UI at admin.daohaus.fun.

Enjoy.
