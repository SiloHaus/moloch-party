# Kickstarter Style Crowdfunding UI for Moloch RDF Treasuries

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


## UI Components

1) Network Connect Support for Optimism | Base [wagami.sh]
2) Integration with Moloch RDF Admin | Claim | RDF Summon App [tailwindCSS|adobeColors]
   * Color and Style coordination with DAOhaus Apps

## Components of a Kickstarter Campaign

1) Video | Pitch [videoEmbed]
2) Contribution Tier I: NFT [mint()]
3) Contribution Tier II: Commissioned NFT [mintComm()]
4) Fundraising Objective with Meter for Success [event()] [contract_Balance] [frontend_meterBar]
5) Campaign Time Limit [frontend_countdown] [commissions_Close] [art_gets_burned] [supplyCap()]
6) Limited Commission Slots [commCap()]
// 7) Reclaim Deposit if Goal is not Met [rageQuit]
// 8) Stretch Goals [merchUpsell]

## Community | Discord Component

1) Getting a Custom Commission requires you to create a ticket in a Discord [discordCommissionBot]
2) Implies a Moloch Captial Discord -- which serves as a project hub for Moloch RDF [discord]
3) Implies a $BAAL Token which can be distributed continuously with new campaigns, to each participant.

## Documentation

1) Github | Artists should be able to fork and follow directions.
2) Gitbook | Users should have an understanding of how things work.

## Artwork CCO

1) Github Repo | Stores CC0 Artwork Contributions

## Socials

1) Farcaster Frames
2) Twitter Video
3) Twitter | Art Banner Repo

## $MOLOCH

* $MOLOCH Distribution:
  * $SILO Holders
  * ALCHEMISTRESSES
  * Campaign Flyer


# INFO

## TODO

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

### DISCORD TICKET BOT

* The Commissions queue is a Discord Ticket Bot, with some basic prompts, and room for reference images to be put into the chat for that specific Issue.

* The commissioner also needs to link their NFT -- specifically so that the TokenID can be associated with their image.

### Anatomy of SILO

* The point here is to show the moloch treasury structure, as well as the 6551 Membership Structure.

* We also want to provide links here to Activation and Admin.

### Equity and RageQuit

* The point here is to explain Equity | RageQuit rights, and limitations of only Rage Quitting Liquid Values.

* We also want to cover Treasury Dissolution.

### Treasury Balance Sheet Page [deBankBalances, nftBalances, freshBatch, commBank, equityContributions]

* Use [deBank API](https://docs.cloud.debank.com/en/readme/api-pro-reference/user) for Token Balances | NFT Balances

* Treasury Balance Sheet can also have prospective value -- meaning the allocation of funds raised from the campaign. Total Value in this case, is broken up into
  * 3 ETH for Shizzy to paint 69
  * 0.2 ETH per Commission that Shizzy is raising to do Custom Work
  * Equity Contributions, and their intention for this campaign.

* At a glance, this section should show what the balance sheet looks like as of now, and what it will look like when more people contribute for this campaign.

### SOCIALS

* X
* WARPCASTER
* Discord
* Github

.:.

## START

npm run dev
Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `pages/index.tsx`. The page auto-updates as you edit the file.

## REF

* [RainbowKit Documentation](https://rainbowkit.com)
* [wagmi Documentation](https://wagmi.sh)
* [Next.js Documentation](https://nextjs.org/docs)
* [the RainbowKit GitHub repository](https://github.com/rainbow-me/rainbowkit)

## DEPLOY

* [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme)
* [Next.js deployment documentation](https://nextjs.org/docs/deployment)

* moloch.party URL for pop-up Campaigns.
* 1.moloch.party could be a compelling URL structure, and then we could have a record list of past campaigns, where people can check to see how much was raised.
