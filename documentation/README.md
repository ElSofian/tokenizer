## Introduction

Token42 est un token ERC-20 déployé sur le testnet Sepolia d'Ethereum.

- **Nom** : Token42
- **Ticker** : TK42
- **Décimales** : 18
- **Supply initial** : 1 000 000 TK42
- **Réseau** : Ethereum Sepolia Testnet
- **Adresse du contrat** : `0xD85BAdE7912c03F56707701D77a81a064118a163`
- **Scanner** : https://sepolia.etherscan.io/token/0xD85BAdE7912c03F56707701D77a81a064118a163

## Le standard ERC-20

ERC-20 est le standard officiel pour les tokens sur Ethereum. Il définit un ensemble
de fonctions que tout token doit implémenter pour être compatible avec l'écosystème
(wallets, exchanges, autres contrats). Token42 implémente ce standard intégralement.

## Ownership

Le contrat utilise un système d'ownership. L'adresse qui déploie le contrat devient
automatiquement le owner. Toutes les autres fonctions sont accessibles à n'importe quelle
adresse.

## Fonctions disponibles

### Lecture (gratuites)

- `name()` : retourne le nom du token (Token42)
- `symbol()` : retourne le ticker (TK42)
- `decimals()` : retourne le nombre de décimales (18)
- `totalSupply()` : retourne le supply total en circulation
- `balanceOf(address)` : retourne le solde d'une adresse
- `allowance(owner, spender)` : retourne le montant qu'une adresse est autorisée à dépenser au nom d'une autre
- `owner()` : retourne l'adresse du propriétaire du contrat

### Écriture (nécessitent du gas)

- `transfer(to, value)` : envoie des tokens à une adresse
- `approve(spender, value)` : autorise une adresse à dépenser des tokens en ton nom
- `transferFrom(from, to, value)` : transfère des tokens au nom d'une adresse
- `mint(to, value)` : crée de nouveaux tokens
- `burn(value)` : détruit des tokens de son propre solde

### Exemples

| Fonction | Paramètres | Description |
|----------|------------|-------------|
| `transfer` | `0x000000000000000000000000000000000000dEaD`, `1000000000000000000` | Transfère 1 TK42 à une adresse (burner ici) |
| `mint` | `0x45219cdDfB4F7ff0496fCE728d212Bad12B2cdF7`, `1000000000000000000` | Crée 1 TK42 et l'envoie à une adresse (owner uniquement) |
| `burn` | `1000000000000000000` | Détruit 1 TK42 de son propre solde |
| `approve` | `0x8a5D6c8F958287e9EeE0B77df2462Ad9de58F0E7`, `5000000000000000000` | Autorise une adresse à dépenser 5 TK42 |
| `transferFrom` | `0x45219cdDfB4F7ff0496fCE728d212Bad12B2cdF7`, `0x8a5D6c8F958287e9EeE0B77df2462Ad9de58F0E7`, `1000000000000000000` | Transfère 1 TK42 au nom d'une adresse |

## Interagir avec le token

### Via Etherscan

1. Rendez-vous sur https://sepolia.etherscan.io/token/0xD85BAdE7912c03F56707701D77a81a064118a163
2. Cliquez sur l'onglet **Contract** puis **Write Contract**
3. Cliquez sur **Connect to Web3** et connectez votre wallet MetaMask
4. Vous pouvez maintenant appeler toutes les fonctions d'écriture directement

## Déployer le token

### Prérequis

- Node.js v18+
- Un wallet MetaMask avec des SepoliaETH (possibilité d'en obtenir via https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
- Un RPC URL Sepolia (obtenu gratuitement via https://alchemy.com)

### Déploiement

1. Allez dans le dossier `deployment/`
2. Installez les dépendances : `npm install`
3. Copiez le fichier d'exemple : `cp .env.example .env`
4. Remplissez le `.env` avec votre RPC URL et votre clé privée
5. Copiez le contrat dans deployment : `cp ../code/Token42.sol contracts/`
6. Compilez le contrat : `npx hardhat compile`
7. Déployez : `npx hardhat run scripts/deploy.ts --network sepolia`