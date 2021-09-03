//
//  HarryPotterCharactersModel.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 16.08.2021.
//

import RxCocoa

final class CharacterListViewModel: ICharacterListViewModel {
    // MARK: - Variables
    
    private var apiService: APICaller!
    private lazy var coreData: CoreDataManager = CoreDataManager()
    var coordinator: CharacterListCoordinator?
    private var names = [String]()
    private var _characters: BehaviorRelay<[Character]> = BehaviorRelay<[Character]>(value: [])
    
    // MARK: - Properties
    
    var characters: Driver<[Character]> {
        return _characters.asDriver()
    }
    
    var numberRowsInSection: Int {
        return _characters.value.count
    }
    
    // MARK: - Initializer
    
    init(){
        self.apiService = APICaller()
    }
    
    // MARK: - Functions
    
    func didSelectRow(_ index: Int) {
        coordinator?.startCharacterDetails(data: _characters.value[index])
    }
    
    func fetchDataFromAPI() {
        // To do data fetch
        apiService.downloadCharacters { [weak self] datas in
            guard let datas = datas else {return}
            guard let self = self else {return}
            self._characters.accept(datas)
        }
    }
    
    func fetchCharacterFromCoreData() {
        let characters = coreData.fetchCharacters()
        print("Characters: \(characters)")
        self.names.removeAll(keepingCapacity: false)
        for data in characters {
            if let name = data.value(forKey: "name") as? String {
                names.append(name)
            }
        }
    }
    
    func viewModelForCell(_ index: Int) -> CharacterCellViewModel {
        return CharacterCellViewModel(character: _characters.value[index], names: names)
    }
    
}

// MARK: - Protocols

protocol ICharacterListViewModel {
    func didSelectRow(_ index: Int)
    func fetchDataFromAPI()
    func viewModelForCell(_ index: Int) -> CharacterCellViewModel
    func fetchCharacterFromCoreData()
}
