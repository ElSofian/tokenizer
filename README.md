# Tokenizer

## Choix de la blockchain
J'ai choisi **Ethereum** avec le testnet **Sepolia** pour les raisons suivantes :
- BEP-20 demandait des fonds de départ
- ERC-20 est le standard le plus documenté et utilisé pour les tokens
- Les outils disponibles (Remix, Hardhat, Etherscan) sont matures et bien documentés
- Aucun vrai argent n'est nécessaire grâce au testnet

## Choix du langage
J'ai utilisé **Solidity 0.8.34** car c'est le langage natif des smart contracts Ethereum.
Il respecte le standard **ERC-20** et c'est la dernière version stable.

## Contrat déployé
- **Réseau** : Ethereum Sepolia Testnet
- **Adresse du contrat** : `0xD85BAdE7912c03F56707701D77a81a064118a163`
- **Scanner** : https://sepolia.etherscan.io/token/0xD85BAdE7912c03F56707701D77a81a064118a163

## Structure
- `code/` : contient le smart contract Solidity
- `deployment/` : contient les outils de déploiement via Hardhat
- `documentation/` : contient la documentation concernant l'usage de Token42