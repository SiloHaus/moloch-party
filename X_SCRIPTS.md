# SCRIPTS

## TierI

* scripts/TierI/deploy.ts
* Requires Parent Manifold Contract Address.
``` npx hardhat run scripts/TierI/deploy.ts --network sepolia ```

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
