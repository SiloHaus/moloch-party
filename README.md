## Todo: 

// OG NFT Sale Repo -- this solves the 14 inside of the treasury, and deposits them into a contract that people can mint from.
// Check lazyMint Deploy to see if any purchases, and then nullify contract, and restart using Splits for payments.
// Combine the Repos into one -- and brand it as a Kickstarter Repo.
// Check Splits | Withdraw for each Contract
// Create Commissions MetaData Folder
// Ask Shizzy to create Comm Placeholder Image
// Create a Readme, which briefly summarizes how to use these together with Moloch RDF

## Contracts

Contracts are Manifold Extensions, which work together to create a Kickstarter Launch | Minter Experience.

* MintExtension.sol
  * A Mint Extension for a Manifold PFP Project.
* CommExtension.sol
  * A Commission Extension for a Manifold Collection, which allows for Minters to order custom pieces which exist with the same contract.
  * [manifold-lazyMint](https://github.com/SiloHaus/manifold-lazyMint)
* PreTransferHook.sol
  * A check to make sure all NFTs which are transferred still hold their Moloch Shares in their Tokenbound Accounts.
  * [manifold-approveTransfer](https://github.com/SiloHaus/manifold-approveTransfer)
* DAOInventory.sol
  * A distribution for the existing 14 NFTs in the DAO Treasury.

## Tools

* Moloch RDF Summoner
* Moloch RDF Admin | Claim App
* [Hashlips | Generative Traits Art Engine](https://github.com/HashLips/hashlips_art_engine)
* [Splits.org](https://app.splits.org/accounts/0xEBae01221b1C1F8c8694967A16389893C04b381F/?chainId=10)
  * Payment Splits contract with UI, on Optimism.

## Payments

withdraw() sends funds to a contract on splits.org.

These two contracts have a split where 2.5% goes to the Alchemix OP Treasury for Grants, the rest is DAO Equity.
* Alchemistresses OG NFT: 0.42 ETH
* Side Batch NFT: 0.42 ETH

CommExtension uses a split which also pays Shizzy.ETH as an artist to create the custom art.
* Commission: 0.5 ETH
  * 84% DAO Equity
  * 2.5% Alchemix OP Treasury Grants
  * 13.5% Shizzy

These Balances are slightly offset by a 1% contribution to Splits.