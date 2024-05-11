// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
// exercice sur base https://docs.base.org/base-camp/docs/new-keyword/new-keyword-exercise/
import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable(msg.sender) {
    // Définir une valeur privée à usage interne
    string private salt = "value"; 

    // Definir un struct pour representer contact
    struct Contact {
        uint id; // Identifiant unique
        string firstName; // Prenom
        string lastName; // Nom
        uint[] phoneNumbers; // Array qui stoke de multiple numéros de telephone pour contact
    }

    // Array tous les contacts
    Contact[] private contacts;

    // Mapping pour stocker l'index de chaque contact dans le tableau des contacts en utilisant son ID
    mapping(uint => uint) private idToIndex;

    // Variable qui garde une trace de l'identifiant pour le prochain contact
    uint private nextId = 1;

    // Erreur personnalisée lorsqu'un contact n'est pas trouvé
    error ContactNotFound(uint id);

    // Function pour ajouter un contact
    function addContact(string calldata firstName, string calldata lastName, uint[] calldata phoneNumbers) external onlyOwner {
        // Créez un nouveau contact avec les détails fournis et ajoutez-le au tableau de contacts
        contacts.push(Contact(nextId, firstName, lastName, phoneNumbers));
        // Mappez l'ID du nouveau contact à son index dans le tableau
        idToIndex[nextId] = contacts.length - 1;
        // Incrémentez le nextId pour le prochain contact
        nextId++;
    }

    // Fonction pour supprimer un contact par son identifiant
    function deleteContact(uint id) external onlyOwner {
        // Récupérer l'index du contact à supprimer
        uint index = idToIndex[id];
        // Vérifiez si l'index est valide et si le contact avec l'ID fourni existe
        if (index >= contacts.length || contacts[index].id != id) revert ContactNotFound(id);

        // Remplacez le contact à supprimer par le dernier contact du tableau
        contacts[index] = contacts[contacts.length - 1];
        // Mettre à jour le mappage d'index pour le contact déplacé
        idToIndex[contacts[index].id] = index;
        // Supprimer le dernier contact du tableau
        contacts.pop();
        // Supprimer l'entrée de mappage pour l'ID de contact supprimé
        delete idToIndex[id];
    }

    //fonction pour récupérer un contact par son identifiant
    function getContact(uint id) external view returns (Contact memory) {
        // Récupérer l'index du contact
        uint index = idToIndex[id];
        // Vérifiez si l'index est valide et si le contact avec l'ID fourni existe
        if (index >= contacts.length || contacts[index].id != id) revert ContactNotFound(id);
        // Renvoyer les coordonnées
        return contacts[index];
    }

    // Fonction pour récupérer tous les contacts
    function getAllContacts() external view returns (Contact[] memory) {
        // Returntous les contacts du tableau
        return contacts;
    }
}
