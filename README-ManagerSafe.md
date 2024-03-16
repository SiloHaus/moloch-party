# execTransactionFromModule()

When you [Summon Moloch RDF](https://silohaus.github.io/silo-rdf-summoner/), you have the ability to register a Manager Safe. 

![Screenshot 2024-02-17 at 2 53 54 PM](https://github.com/SiloHaus/transaction-builder/assets/54530373/f9ee6c95-05c7-41d6-9c49-c543743bb83a)

The Manager Safe has total control over the DAO Treasury, however, you need to use some arcane spells:

In the case of the Alchemistresses, you need to use execTransactionFromModule(), which is located in the ABI for this Gnosis Safe Implementation:
* [0xfb1bffc9d739b8d520daf37df666da4c687191ea](https://optimistic.etherscan.io/address/0xfb1bffc9d739b8d520daf37df666da4c687191ea#writeContract)

The Actual DAO Treasury doesn't have the function in its ABI:
* [0x7BE79ec75d58FCD1053ef42397967abD3e1A8Df6](https://optimistic.etherscan.io/address/0x7BE79ec75d58FCD1053ef42397967abD3e1A8Df6#writeContract)

From the Manager Safe, you need to use Transaction Builder, and then it looks kind of like this: 

![Transaction](https://github.com/SiloHaus/transaction-builder/assets/54530373/8e979e0a-59d4-44e4-8881-719c3bd41bb4)

1) The Parent SAFE Contract offers the ABI and execTransactionFromModule() function.
2) ABI from that contract
3) The SAFE | DAO TREASURY which is going to have that execTransactionFromModule() called on it. 
4) The Contents of that execTransactionFromModule()
  * EX: 0x4200000000000000000000000000000000000006 the WETH Address is called
  * deposit()
  * 21700000000000000000 21.7 ETH into WETH

Essentially, you are packaging this: 

![Screenshot 2024-02-17 at 3 10 07 PM](https://github.com/SiloHaus/transaction-builder/assets/54530373/d4b1b555-2945-423c-90e4-d740ceb02899)

Into this: 

![Screenshot 2024-02-17 at 3 11 31 PM](https://github.com/SiloHaus/transaction-builder/assets/54530373/aa4d1dd6-7e73-430c-b858-33f27cc2877e)

This is accomplished by taking the Data from the first bundle, and depositing that Data into the second bundle. 

DekanBro made this video explainer: 
* https://www.loom.com/share/0524ef8a3e3149e1b3171e3728b762f5?sid=8cf09177-be4a-46e4-8488-8dfa2d18af6f

## Useful: 

Tenderly can help you dissect and test these transactions: 
* https://dashboard.tenderly.co/tx/optimistic/0x3af106176368d6771989ac9511a9581ae67e533025530030a0d872839d4064ae/contracts
