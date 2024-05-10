# SCRIPTS

* scripts/deploy.ts
* Requires Parent Manifold Contract Address.
``` npx hardhat run scripts/deploy.ts --network sepolia ```

Deployment also takes care of:

* baseURI
* setMolochPartyAddress

## TierII

* scripts/TierII/getMintedTokenIds.ts
* Requires TierII Contract Address.
``` npx hardhat run scripts/TierII/getMintedTokenIds.ts --network sepolia ```
