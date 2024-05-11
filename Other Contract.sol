// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Import AddressBook contract pour interagir avec
import "./AddressBook.sol";

// Contract pour instancier AddressBook qui fait partie de l'exercice 
// https://docs.base.org/base-camp/docs/new-keyword/new-keyword-exercise/
contract AddressBookFactory {
    // Definir une veleur interne
    string private salt = "value";

    // fonction pour deployer une noouvelle instance de AddressBook
    function deploy() external returns (AddressBook) {
        // créer une instance nouvelle
        AddressBook newAddressBook = new AddressBook();

        // transférer la propriété du nouveau contrat AddressBook à l'appelant de cette fonction
        newAddressBook.transferOwnership(msg.sender);

        // Renvoyez le contrat AddressBook nouvellement créé
        return newAddressBook;
    }
}
