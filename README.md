# Allowance Spike Trap (Drosera Testnet)

This project implements a custom **Allowance Spike Trap** for the Drosera Testnet (https://drosera.network/).

## 📜 Contract
- \`AllowanceSpikeTrap_Custom.sol\`
- This trap monitors the allowance of an ERC20 token and triggers a response if the allowance exceeds a certain threshold.
- **Token**: `0x499b095Ed02f76E56444c242EC43A05F9c2A3ac8`
- **Owner**: `0x216a54E8bFD7D9bB19fCd5730c072F61E1Af2309`
- **Spender**: `0x8164139a6aA30944D991e67A09bbdf2cb96E8b80`
- **Threshold**: `100 * 10^18` (100 tokens assuming 18 decimals)

## ⚙️ Configuration
\`drosera.toml\` defines the trap parameters for Drosera relay, including:
- RPC endpoints
- Trap contract deployment paths
- Response contract and function
- Operator requirements

## 🚀 Usage
1. **Compile contract: forge build**
2. **Deploy on Drosera testnet.**
3. **Register the trap with \`drosera.toml\`.**

---
- **Author** : TheBaldKid
- **Network** : Hoodi Testnet (Chain ID: 560048)
- **Status** : Deployed and Active (https://app.drosera.io/trap?trapId=0x277c8491fa436f9916dcd441b044d00a571cf338&chainId=560048)
- **Category** : Allowance Spike Trap

