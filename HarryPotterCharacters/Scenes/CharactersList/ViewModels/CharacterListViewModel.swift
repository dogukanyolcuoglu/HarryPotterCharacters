//
//  HarryPotterCharactersModel.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 16.08.2021.
//

import UIKit
import Foundation

final class CharacterListViewModel: ICharacterListViewModel {
    // MARK: - Variables & Properties
    
    private var apiService: APICaller!
    private lazy var coreData: CoreDataManager = CoreDataManager()
    var coordinator: CharacterListCoordinator?
    var characters: Observable<[Character]> = Observable([])
    var names: Observable<[String]> = Observable([])
    private(set) var chosenNames = [String]()
    
    // MARK: - Initializer
    
    init(){
        self.apiService = APICaller()
    }
    
    // MARK: - Functions
    
    func didSelectRow(_ index: Int) {
        coordinator?.startCharacterDetails(data: characters.value[index])
    }
   
    func fetchDataFromAPI() {
        apiService.downloadCharacters { [weak self] (characters) in
            guard let self = self else {return}
            guard let characters = characters else {return}
            self.characters.value = characters
        }
    }
    
    var numberRowsInSection: Int {
        return characters.value.count
    }
        
    func viewModelForCell(_ index: Int) -> CharacterListCellViewModel {
        return CharacterListCellViewModel(character: characters.value[index], names: chosenNames)
    }
    
    func fetchCharacterFromCoreData() {
        let characters = coreData.fetchCharacters()
        print("Characters: \(characters)")
        self.chosenNames.removeAll(keepingCapacity: false)
        for data in characters {
            if let name = data.value(forKey: "name") as? String {
                chosenNames.append(name)
            }
        }
        self.names.value = chosenNames
    }
}


// MARK: - Protocols

protocol ICharacterListViewModel {
    func viewModelForCell(_ index: Int) -> CharacterListCellViewModel
    func fetchCharacterFromCoreData()
    func fetchDataFromAPI()
}
