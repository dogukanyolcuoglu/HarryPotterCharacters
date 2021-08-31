//
//  HarryPotterCharactersVC.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 27.07.2021.
//

import UIKit

final class CharacterListViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    var viewModel: CharacterListViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Functions
    
    private func setupViews() {
        configuration()
        reloadFavoritesClosure()
        if NetworkMonitor.shared.isConnected {
            print("\nYou're connected\n")
            reloadCharactersClosure()
        } else {
            print("\nYou're not connected\n")
        }
    }
    
    func reloadFavoritesClosure() {
        viewModel.fetchCharacterFromCoreData()
        viewModel.names.bind { [weak self] _ in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func reloadCharactersClosure() {
        viewModel.fetchDataFromAPI()
        viewModel.characters.bind { [weak self] _ in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configuration() {
        // Navigation settings
        navigationItem.title = "Harry Potter Movie"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // TableView Delegates
        tableView.delegate = self
        tableView.dataSource = self
        //Row
        tableView.rowHeight = 100
        //Properties
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
}

// MARK: - TableView Datasource & Delegate

extension CharacterListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharacterListCell
        
        let cellViewModel = viewModel.viewModelForCell(indexPath.row)
        cell.configureCharacter(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
