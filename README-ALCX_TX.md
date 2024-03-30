# ALCX MANAGER

## Lido Deposit

Lido Gateway: 0xDB3fE4Da32c2A79654D98e5a41B22173a0AF3933
// Transaction Approval Batch March 15th.

depositUnderlying()
0xDB3fE4Da32c2A79654D98e5a41B22173a0AF3933
Value: 7000000000000000000
alchemist: 0xe04Bb5B4de60FA2fBa69a93adE13A8B3B569d5B4
yieldToken: 0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb
Value: 7000000000000000000
recipient: 0x7BE79ec75d58FCD1053ef42397967abD3e1A8Df6 // Alchemistresses Treasury
minimumAmountOut: 6993000000000000000

## yVault Deposit

Yearn Gateway: 0xedE36d3F423EF198abE82D2463E0a18bcF2d9397
Yield Token: 0x5B977577Eb8a480f63e11FC615D6753adB8652Ae
// Transaction Approval Batch March 15th.

## alETH Borrow

1. mint()
   * 0xe04bb5b4de60fa2fba69a93ade13a8b3b569d5b4
   * Value: 7000000000000000000
   * recipient: 0x7BE79ec75d58FCD1053ef42397967abD3e1A8Df6

## Deposit alETH/ETH LP on Velodrome

// Completed deposit()

1. deposit() // This is going to convert 7 ETH to 7 WETH
   * 0x4200000000000000000000000000000000000006
   * Value: 7000000000000000000

2. approve() // This is going to approve Velodrome to spend 7 WETH
   * 0x4200000000000000000000000000000000000006
   * Velodrome v2 Router Contract: 0xa062ae8a9c5e11aaa026fc2670b0d65ccc8b2858
   * value: 7000000000000000000
  
  // Transaction Approval Batch March 15th.


3. approve() // This is going to approve Velodrome to spend 7 alETH
   * alETH Token: 0x3E29D3A9316dAB217754d13b28646B76607c5f04
   * Velodrome v2 Router Contract: 0xa062ae8a9c5e11aaa026fc2670b0d65ccc8b2858
   * value: 7000000000000000000

  // Transaction Approval Batch March 15th.

4. addLiquidity() // This adds both alETH and WETH into the LP and deposits the LP Token
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

## ALCHEMIX ABI

[{"inputs":[{"internalType":"address","name":"weth","type":"address"},{"internalType":"address","name":"_whitelist","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"string","name":"message","type":"string"}],"name":"IllegalArgument","type":"error"},{"inputs":[{"internalType":"string","name":"message","type":"string"}],"name":"IllegalState","type":"error"},{"inputs":[{"internalType":"string","name":"message","type":"string"}],"name":"Unauthorized","type":"error"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"inputs":[],"name":"WETH","outputs":[{"internalType":"contract IWETH9","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"alchemist","type":"address"},{"internalType":"address","name":"yieldToken","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"minimumAmountOut","type":"uint256"}],"name":"depositUnderlying","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"alchemist","type":"address"}],"name":"refreshAllowance","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"version","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"whitelist","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"alchemist","type":"address"},{"internalType":"address","name":"yieldToken","type":"address"},{"internalType":"uint256","name":"shares","type":"uint256"},{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"minimumAmountOut","type":"uint256"}],"name":"withdrawUnderlying","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]