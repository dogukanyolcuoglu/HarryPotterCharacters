//
//  CharacterListCellViewModel.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 25.08.2021.
//

import Foundation

final class CharacterListCellViewModel {
    var name: String
    var species: String
    var image: String
    var names: [String]
    
    init(character: Character, names: [String]) {
        self.name = character.name
        self.species = character.species
        self.image = character.image
        self.names = names
    }
}
