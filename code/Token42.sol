// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

// Contrat ERC-20 : standard officiel pour les tokens sur Ethereum
// Il définit un ensemble de fonctions et d'événements que tout token doit implémenter
contract Token42 {

    // Informations du token (lisibles publiquement)
    string public name = "Token42";     // Nom complet du token
    string public symbol = "TK42";      // Ticker affiché sur les scanners
    uint8 public decimals = 18;         // Standard ERC-20 : 1 token = 10^18 unités soit 1000000000000000000
    uint256 public totalSupply;         // Nombre total de tokens en circulation

    // Dictionnaire adresse => solde : permet de savoir combien de tokens possède chaque adresse
    mapping(address => uint256) public balanceOf;

    // Dictionnaire adresse => (adresse => montant autorisé) : système d'approbation ERC-20
    // Permet à une adresse d'autoriser une autre à dépenser des tokens en son nom
    mapping(address => mapping(address => uint256)) public allowance;

    // Adresse du propriétaire du contrat
    address public owner;

    // Événements obligatoires du standard ERC-20
    // Émis à chaque transfert de tokens entre deux adresses
    event Transfer(address indexed from, address indexed to, uint256 value);
    // Émis quand une adresse autorise une autre à dépenser en son nom
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Modificateur de sécurité : bloque l'exécution si l'appelant n'est pas le owner
    // Utilisé sur les fonctions réservées au propriétaire (ex: mint)
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _; // Le code de la fonction s'exécute ici si la condition est remplie
    }

    // Exécuté une seule fois au déploiement
    // Définit le owner et crée le supply initial dans son wallet
    constructor(uint256 _initialSupply) {
        owner = msg.sender;                              // Le déployeur devient le owner
        totalSupply = _initialSupply * 10 ** decimals;  // Conversion en unités (ex: 1M * 10^18)
        balanceOf[msg.sender] = totalSupply;             // Tout le supply va au owner au départ
    }

    // Transfère des tokens de l'appelant vers une adresse cible
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // Vérifie le solde
        balanceOf[msg.sender] -= _value; // Débite l'appelant
        balanceOf[_to] += _value;        // Crédite le destinataire
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Autorise une adresse (_spender) à dépenser jusqu'à _value tokens au nom de l'appelant
    // Nécessaire avant tout appel à transferFrom
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Transfère des tokens au nom d'une adresse (_from) vers une adresse cible (_to)
    // Nécessite que _from ait préalablement appelé approve pour autoriser msg.sender
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(balanceOf[_from] >= _value, "Insufficient balance");       // Vérifie le solde de _from
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded"); // Vérifie l'autorisation
        balanceOf[_from] -= _value;              // Débite _from
        balanceOf[_to] += _value;                // Crédite _to
        allowance[_from][msg.sender] -= _value;  // Réduit l'allowance consommée
        emit Transfer(_from, _to, _value);
        return true;
    }

    // Crée de nouveaux tokens et les envoie à une adresse
    // Réservé au owner grâce au modifier onlyOwner
    // address(0) comme émetteur est la convention ERC-20 pour signaler une création de tokens
    function mint(address _to, uint256 _value) public onlyOwner {
        totalSupply += _value;       // Augmente le supply total
        balanceOf[_to] += _value;    // Crédite l'adresse cible
        emit Transfer(address(0), _to, _value);
    }

    // Détruit des tokens du wallet de l'appelant
    // Réduit le supply total de façon permanente
    // address(0) comme destinataire est la convention ERC-20 pour signaler une destruction de tokens
    function burn(uint256 _value) public {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // Vérifie le solde
        totalSupply -= _value;           // Réduit le supply total
        balanceOf[msg.sender] -= _value; // Débite l'appelant
        emit Transfer(msg.sender, address(0), _value);
    }
}