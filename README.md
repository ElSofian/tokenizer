# Tokenizer

## Choix de la blockchain
J'ai choisi **Ethereum** avec le testnet **Sepolia** pour les raisons suivantes :
- BEP-20 demandait des fonds de départ
- ERC-20 est le standard le plus documenté et utilisé pour les tokens
- Les outils disponibles (Remix, Hardhat, Etherscan) sont stables et bien documentés

## Choix du langage
J'ai utilisé **Solidity 0.8.34** car c'est le langage natif des smart contracts Ethereum.
Il respecte le standard **ERC-20** et c'est la dernière version stable.

## Structure
- `code/` : contient le smart contract Solidity
- `deployment/` : contient les outils de déploiement via Hardhat
- `documentation/` : contient la documentation concernant l'usage de Token42