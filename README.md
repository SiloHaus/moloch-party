# MOLOCH.PARTY | OPTIMISTIC LANDSCAPES

OP Mainnet:

Creator Address deployed to: [0x8567Ad6A6F2274bddca41d6F5c235e66E2d17dE9](https://optimistic.etherscan.io/address/0x8567ad6a6f2274bddca41d6f5c235e66e2d17de9#code)
MolochParty deployed to: [0xD84D227b2965a011561FDD6C2782bA74d4551c51](https://optimistic.etherscan.io/address/0xD84D227b2965a011561FDD6C2782bA74d4551c51#code)
TierI deployed to: [0x501f614674896972194Fd7ee2A2089B2b8B575F2](https://optimistic.etherscan.io/address/0x501f614674896972194fd7ee2a2089b2b8b575f2#code)
TierII deployed to: [0x447B8A9F8438Fd85058c5d38a4c3Ac74A1ce1C82](https://optimistic.etherscan.io/address/0x447b8a9f8438fd85058c5d38a4c3ac74a1ce1c82#code)

TierI Verification:
``` npx hardhat verify --network optimism 0x501f614674896972194Fd7ee2A2089B2b8B575F2 0x8567Ad6A6F2274bddca41d6F5c235e66E2d17dE9 ```

TierII Verification:
``` npx hardhat verify --network optimism 0x447B8A9F8438Fd85058c5d38a4c3Ac74A1ce1C82 0x8567Ad6A6F2274bddca41d6F5c235e66E2d17dE9 ```

MolochParty Verification:
``` npx hardhat verify --network optimism 0xD84D227b2965a011561FDD6C2782bA74d4551c51 9 1 0xF1B3A985E3aC73dc81f8fcD419c4dda247d2292c 0x5304ebB378186b081B99dbb8B6D17d9005eA0448 100000000000000000 100000000000000000 0x501f614674896972194Fd7ee2A2089B2b8B575F2 0x447B8A9F8438Fd85058c5d38a4c3Ac74A1ce1C82 10 ```

## OBJECTIVE

Kickstarter for Manifold Landscape Collections on Optimism.

Each Campaign has two Tiers:

* TierI: OP LANDSCAPES
* TierII: PIXEL LANDSCAPES

All NFTs minted are part of the same Contract | Collection, and have sequential TokenIDs.

## TREAUSRY ADDRESSES

Moloch Vault: 0x
Artist Vault: 0x

## AKORD BASEURI

* TierI: [Landscapes BaseURI](https://iuez62szp7zcimgovqo3finks7ziz532jvsfndb6zereqsktdzia.arweave.net/RQmfall_8iQwzqwdsqGql_KM93pNZFaMPskiSElTHlA/JSON/)
* TierII: [PixelLandscapes BaseURI](https://iuez62szp7zcimgovqo3finks7ziz532jvsfndb6zereqsktdzia.arweave.net/RQmfall_8iQwzqwdsqGql_KM93pNZFaMPskiSElTHlA/PIXELJSON/)

## MOLOCH RDF | TOOLS

* [RDF Summoner on OP | BASE](https://silohaus.github.io/silo-rdf-summoner/)
* [RDF Admin App](https://silohaus.github.io/silo-nft-dao-admin/)
* [RDF Activation](https://silohaus.github.io/silo-nft-dao-admin/#/molochv3/0xa/0x912aab5913023d20a5dcd17160e6954528433a7f/activate)
* [Hashlips | Generative Traits Art Engine](https://github.com/HashLips/hashlips_art_engine)

## REFERENCE

* [Tokenbound Accounts](https://docs.tokenbound.org/)
* [Manifold TokenURI Documentation](https://docs.manifold.xyz/v/manifold-for-developers/smart-contracts/manifold-creator/contracts/extensions/extensions-functions#setbasetokenuriextension)
* [Manifold Developer Documentation](https://docs.manifold.xyz/v/manifold-for-developers/smart-contracts/manifold-creator/contracts/extensions/extensions-functions)
* [AKORD Documentation](https://docs.akord.com/nfts/storing-nft-assets-on-arweave/generating-manifests-in-akord-vaults)
* [OpenSea Metadata Standards](https://docs.opensea.io/docs/metadata-standards)
