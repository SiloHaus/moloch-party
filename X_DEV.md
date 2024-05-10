# CONTRACTS

To reduce size, and for simplicity, I am structuring this so that each campaign needs to be launched manually, rather than have a factory structure.

## MolochParty.sol

### fundingGoal.tsx [raisedAmount, goalAmount, stretchAmount] // Update | Reduce Variables on Frontend

* The Funding Meter on the Frontend shows how many NFTs have sold in the Campaign, and has an overflow for Commissions when Sold Out.

raisedAmount == the sum of all funds raised, including commissions.
stretchAmount == [mintSupply * commPrice]
goalAmount == [mintSupply * costToMint]

### React Hooks: memberCount.tsx [memberNumber]

* Number of Moloch Shares for the Collection being Raised.

// Use Etherscan API.

### React Hooks: daysLeft.tsx [daysLeft]

* Time Limited Campaign.

uint256 _durationInDays,

event CampaignFinalized(uint256 totalMinted, uint256 timeFinalized);

## TierI.sol

* A Mint Extension for a Manifold PFP Project.

### React Hooks: tier1.tsx [ogLeft, sideBatch] // Update | Remove Variables on Frontend

uint256 public totalMinted; // Track the total number of NFTs minted

function contributeTierI()
  _handleContribution(costToMint, msg.sender, 1)
    function mint(address recipient)
      event TokenMinted(uint256 totalMinted);

function finalizeCampaign()
  tierIContract.mintBatch(molochVault, remainder)
    function mintBatch(address recipient, uint256 remaining)
      emit CampaignFinalized(totalMinted, block.timestamp);

## TierII.sol

* A Commission Extension for a Manifold Collection, which allows for Minters to order custom pieces which exist with the same contract.

// Create Commissions MetaData Folder on Akord for TESTNET.

### React Hooks: tier2.tsx [commLeft] // Update | Removee Variables on Frontend

uint256 public totalMinted; // Track the total number of NFTs minted

function contributeTierII()
  _handleContribution(costToMint, msg.sender, 2)
    function mintComm(address recipient)
      event TokenMinted(uint256 totalMinted);

// Control how many commissions you offer by setting a correct price.

## PreTransferHook.sol | INFRA SECURITY

* A Manifold Extension which checks that a NFT still holds its Moloch Share before Transfer.

0) Deploy RDF for Manifold Contract | This creates MolochShare Token, which is checked for in the PreTransferHook.
1) Set the variables in the deploy.js file for the Pre-Transfer Hook Extension.
2) Deploy Pre-Transfer Hook Extension to protect against selling NFTs after burning shares
3) Register the Pre-Transfer Hook Extension as an Extension in Manifold Studio
4) Enter the contract address into setApproveTransfer() in your Manifold NFT Contract Write as Proxy section on OP Etherscan
5) addApprovedAddress() for necessary sales and treasury addresses in OP Etherscan for your Extension Contract

## PartyRegistry.sol | INFRA DATA

* You can create a PartyRegistry, which each campaign registers with on launch -- it would be more for long term housekeeping.

## DISCORD | TICKET BOT

* NFT Gated Discord Server. Ticket Bot has References and Commissioner provides TokenID, Description, References.
