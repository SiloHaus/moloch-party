# ACLX MANAGER

execTransactionAsModule() contained within the ABI of:
0xfb1bffc9d739b8d520daf37df666da4c687191ea

## Unstake yvWETH

0xe35fec3895dcecc7d2a91e8ae4ff3c0d43ebffe0

{
    "func": "exit",
    "params": []
}

### Deposit yvWETH via Gateway to stakeETH position

0xede36d3f423ef198abe82d2463e0a18bcf2d9397

{
    "func": "deposit",
    "params": [
        "0xE62DDa84e579e6A37296bCFC74c97349D2C59ce3",
        9725342115185895,
        "0xF1B3A985E3aC73dc81f8fcD419c4dda247d2292c"
    ]
}

## alETH BORROW

1. mint()
   * 0xe04bb5b4de60fa2fba69a93ade13a8b3b569d5b4
   * Value: 7000000000000000000
   * recipient: 0x7BE79ec75d58FCD1053ef42397967abD3e1A8Df6

## Deposit alETH/ETH LP on Velodrome

1. addLiquidity() // This adds both alETH and WETH into the LP and deposits the LP Token
   * 0xa062aE8A9c5e11aaA026fc2670B0D65cCc8B2858
   * Token A Address: 0x3E29D3A9316dAB217754d13b28646B76607c5f04
   * Token A Address: 0x4200000000000000000000000000000000000006
   * Stable Pool Bool: true
   * VALUE alETH: 7000000000000000000
   * VALUE WETH: 3619035205379591493
   * VALUE alETH Slippage: 6993000000000000000
   * VALUE WETH Slippage: 3615416170174212000
   * recipient: 0x7BE79ec75d58FCD1053ef42397967abD3e1A8Df6
   * Unix Timestamp: 1707861600 // This tx is good until Feb 13th @ 4PM

LP Token sAMMV2-alETH/WETH: 0xa1055762336f92b4b8d2edc032a0ce45ead6280a

## Stake alETH/ETH LP on Velodrome

1. approve() // Approve sAMMv2-alETH/WETH contract to be spent by Gauge
   * 0xa1055762336f92b4b8d2edc032a0ce45ead6280a
   * Gauge Contract: 0xc16adBf2d01d6524B79CbB610cE31d5db80eee3C
   * Value: // Amount of LP Token

2. deposit()
   * 0xc16adbf2d01d6524b79cbb610ce31d5db80eee3c
   * Value: // Amount of LP Token

## REFERENCE

In Moloch RDF, you can designate a Manager Safe to act as Controller for an RDF Treasury. The Manager Safe is a Module which has complete control over the treasury and superceeds the use of any voting. Use the Gnosis Safe Transaction Builder to construct data for a transaction, and then bundle that transaction into another transaction which calls ExecTransactionAsModule() on behalf of the DAO Treasury.

* [DekanBro on using Safe Transaction Builder](https://www.loom.com/share/0524ef8a3e3149e1b3171e3728b762f5?sid=8cf09177-be4a-46e4-8488-8dfa2d18af6f)