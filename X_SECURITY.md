## BEST PRACTICES | SECURITY

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
