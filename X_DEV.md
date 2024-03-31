## TODO

## MANIFOLD | TESTNET

* Mint()
  * Spend ApproveAll to sell existing Alchemistresses prior to Mint()
* Comm()
  * Timer
  * Close on Timer
* Withdraw()
  * After Timer is up.
* SetTokenURI()
* ReadBalance Function that is accurate and tells the difference between ETH from Comms and ETH from Mints

### React Hooks

#### fundingGoal.tsx [raisedAmount, goalAmount, stretchAmount]

* raisedAmount needs to exclude commission funds, and only be equity that is raised and deposited toward treasury.

* Withdraws will also need to take place after the campaign concludes, which means that setRaisedAmount needs to be finalized before withdraw() is executed. That way, the campaign registers as completed and funding score remains.

* goalAmount | stretchAmount can be set per campaign.

* raisedAmount needs to exclude commission funds, and if it does, then the gauges will accurately read. This means that there needs to be a splitter inside of the contract which sends the funds off to shizzy's COMM-BANK on contribution. That way, the main funds are always reflective of the balance in the contract.

* Shizzy's COMM-BANK would be a smart contract that receives commission funds, and is only withdrawable by shizzy.eth

#### memberCount.tsx [memberNumber]

* memberNumber is pulled from Moloch Shares which exist in TBAs of Alchemistresses. The numbers will initially be incorrect, until the 14 from the treasury have been absorbed into circulation.

#### daysLeft.tsx [daysLeft]

* daysLeft can be set per Campaign, though for simplicity, and FOMO, it ought to be set to 1. It would be better to have a standard pop up campaign style, with carefully prepared outreach strategies | materials, rather than dead on the water campaigns.

#### tier1.tsx [ogLeft, sideBatch]

* ogLeft == How many Alchemistress | OGs are available and owned by the Treasury. These need to be sold First.

* sideBatch is a variable that does not yet exist. It stands for how many of the Batch II NFTs from Shizzy's collection are minted after the ogLeft == 0.

* ogLeft ought to sell out, and then afterward, if more people want that collection, they can mint from the SideBatch.

* mint() is not longer able to be called, once the campaign has come to an end.

#### tier2.tsx [commLeft]

* commLeft is about how many custom slots Shizzy is willing to take on at once.

* Technically, mintComm() and mint() are two different manifold extensions, under the same NFT Contract, each with their own BaseURI. mintComm() has a placeholder image, all of which are replaced when the commissions have been completed.

* mintComm() is not longer able to be called, once the campaign has come to an end.

.:.

#### DISCORD TICKET BOT

* The Commissions queue is a Discord Ticket Bot, with some basic prompts, and room for reference images to be put into the chat for that specific Issue.

* The commissioner also needs to link their NFT -- specifically so that the TokenID can be associated with their image.

#### BAAL TOKEN

* $BAAL Token which can be distributed continuously with new campaigns, to each participant

## EXTENSION INSTRUCTIONS

1) npx hardhat compile
2) npx hardhat run scripts/deploy.js --network optimism
3) npx hardhat verify --network optimism /*deployed extension contract*/ /*"molochShareAddress"*/ "0x000000006551c19487814612e58FE06813775758" "0x55266d75D1a14E4572138116aF39863Ed6596E7F" "0x0000000000000000000000000000000000000000000000000000000000000000" "10" /*"nftContract from Manifold"*/