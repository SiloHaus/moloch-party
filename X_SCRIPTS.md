# SCRIPTS

Scripts for TierI and TierII are limited, because they are CHILD DELEGATE contracts, and their main scripts are called by MolochParty.sol.

Need to consolidate Scripts so that PartyFactory.sol Admins everything, except initial deployment.

## TierI

* scripts/TierI/deploy.ts
* Requires Parent Manifold Contract Address.
``` npx hardhat run scripts/TierI/deploy.ts --network sepolia ```

These could be controlled by the Factory Contract:

* scripts/TierI/setBaseURI.ts
* Requires PFP BaseURI set from Akord.
* Requires TierI Contract Address.
``` npx hardhat run scripts/TierII/setBaseURI.ts --network sepolia ```
* scripts/TierI/setMolochPartyAddress.ts
* Requires TierI Contract Address.
* Requires MolochParty Address.
``` npx hardhat run scripts/TierII/setMolochPartyAddress.ts --network sepolia ```

## TierII

* scripts/TierII/deploy.ts
* Requires Parent Manifold Contract Address.
``` npx hardhat run scripts/TierII/deploy.ts --network sepolia ```

These could be controlled by the Factory Contract:

* scripts/TierII/setBaseURI.ts
* Requires Commisson Placeholder BaseURI set from Akord.
* Requires TierII Contract Address.
``` npx hardhat run scripts/TierII/setBaseURI.ts --network sepolia ```
* scripts/TierII/setMolochPartyAddress.ts
* Requires TierII Contract Address.
* Requires MolochParty Address.
``` npx hardhat run scripts/TierII/setMolochPartyAddress.ts --network sepolia ```
* scripts/TierII/getMintedTokenIds.ts
* Requires TierII Contract Address.
``` npx hardhat run scripts/TierII/getMintedTokenIds.ts --network sepolia ```
