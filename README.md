# manifold-Commissions

* [manifold-lazyMint](https://github.com/SiloHaus/manifold-lazyMint)

lazyMint sets up an NFT Collection, with images that have been stored already on Arweave, and are minted in sequence.

The purpose is to sell an NFT Collection to raise funds for a community owned treasury, which is established via Moloch RDF.

* [manifold-approveTransfer](https://github.com/SiloHaus/manifold-approveTransfer)

approveTransfer is a Pre-Transfer Hook Extension, which checks whether or not a specific Baal Governance Share exists in a specific Tokenbound account for a specific NFT Contract.

The purpose is to protect against a type of double-spend, where someone RQs their equity, and then sells the NFT. The approveTransfer Hook prevents this, by preventing transfers of NFTs if the Shares are not in the TokenBound Accounts -- or, if the NFTs are held by a whitelisted address, such as a DAO Treasury or a WL Sudoswap Pool.

* [manifold-Commissions](https://github.com/SiloHaus/manifold-Commissions)

manifold-Commissions is a separate mint extension that runs concurrently with lazyMint. 

The purpose is to have a placeholder image with a set amount of possible commission slots, and to have the opportunity for the commission slots to be set during the time period.

## Alchemistresses Application: 

Adding Commissions to an existing campaign is as follows: 

1) Manifold Minter Extension which matches lazyMint
2) 
