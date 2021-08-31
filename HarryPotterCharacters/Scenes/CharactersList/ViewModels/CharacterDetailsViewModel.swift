//
//  CharacterDetailsViewModel.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 23.08.2021.
//

import Foundation

final class CharacterDetailsViewModel: ICharacterDetailsViewModel {
    // MARK: - Variables & Properties
    
    var coordinator: CharacterDetailsCoordinator?
    private lazy var coreData: CoreDataManager = CoreDataManager()
    private var boolValue: Bool = false
    private(set) var chosenCharacter: Character?
    private(set) var chosenNames: [String] = []

    // MARK: - Initializer
    
    init(character: Character) {
        self.chosenCharacter = character
        getUpdatedFavorites()
    }

    // MARK: - Functions
    
    func tappedFavButton() {
        guard let chosenCharacter = chosenCharacter else { return }
        
        if chosenNames.contains(chosenCharacter.name) {
    
            coreData.deleteCharacter(chosenName: chosenCharacter.name)
            getUpdatedFavorites()
            boolValue = false
            coordinator?.didTapFavoriteAction()
            print("Deleted! Updated Array: \(chosenNames)")
            
        } else {
            coreData.saveCharacter(name: chosenCharacter.name)
            getUpdatedFavorites()
            boolValue = true
            coordinator?.didTapFavoriteAction()
            print("Saved! Updated Array: \(chosenNames)")
        }
    }
    
    func isFavorite() -> Bool {
        guard let chosenCharacter = chosenCharacter else {return false}
        for name in chosenNames {
            if name == chosenCharacter.name {
                boolValue = true
                break
            }
        }
        return boolValue
    }
    
    func getUpdatedFavorites() {
        let characters = coreData.fetchCharacters()
        self.chosenNames.removeAll(keepingCapacity: false)
        for character in characters {
            if let name = character.value(forKey: "name") as? String {
                chosenNames.append(name)
            }
        }
    }
}

// MARK: - Protocols

protocol ICharacterDetailsViewModel {
    func isFavorite() -> Bool
    func getUpdatedFavorites()
}
