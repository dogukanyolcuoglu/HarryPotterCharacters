//
//  CharactersDetailsVC.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 2.08.2021.
//

import UIKit
import SDWebImage

final class CharactersDetailsViewController: UIViewController, Storyboarded{
    
    // MARK: - Variables
    
    var viewModel: CharacterDetailsViewModel!
    var favButton = UIBarButtonItem()

    // MARK: - IBOutlets
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var characterDate: UILabel!
    @IBOutlet weak var characterWood: UILabel!
    @IBOutlet weak var characterCore: UILabel!
    
    // MARK: - Cycle state funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - Functions
    
    private func setupViews() {
        guard let character = viewModel.chosenCharacter else {return}
        navigationItem.title = character.name
        setConfigureImage()
        setConfigureLabels()
        setNavigationButton()
        
        // To do set views
        characterImage.sd_setImage(with: URL(string: character.image), completed: nil)
        characterGender.text = !character.gender.isEmpty ? "Gender: \(character.gender)" : "Gender: Null"
        characterDate.text = !character.dateOfBirth.isEmpty ? "DateOfBirth: \(character.dateOfBirth)" : "DateOfBirth: Null"
        characterWood.text = !character.wand.wood.isEmpty ? "Wood: \(character.wand.wood)" : "Wood: Null"
        characterCore.text = !character.wand.core.isEmpty ? "Core: \(character.wand.core)" : "Core: Null"
    }
    
    private func setNavigationButton() {
        self.navigationController?.navigationBar.tintColor = .label
        favButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(tappedFavAction))
        navigationItem.rightBarButtonItem = favButton
        
        if viewModel.isFavorite() {
            favButton = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(tappedFavAction))
            navigationItem.rightBarButtonItem = favButton
        }
    }
    
    @objc func tappedFavAction(){
        viewModel.tappedFavButton()
        setNavigationButton()
    }
    
    private func setConfigureImage() {
        characterImage.layer.masksToBounds = false
        characterImage.layer.cornerRadius = 5
        characterImage.clipsToBounds = true
    }
    
    private func setConfigureLabels() {
        characterGender.setConfigureLabel(label: characterGender)
        characterDate.setConfigureLabel(label: characterDate)
        characterWood.setConfigureLabel(label: characterWood)
        characterCore.setConfigureLabel(label: characterCore)
    }
    
}

// MARK: - Extensions

extension UILabel {
    func setConfigureLabel(label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = UIColor(red: 0.7569, green: 0.0235, blue: 0, alpha: 1.0)
        label.textColor = UIColor(red: 1.00, green: 0.84, blue: 0.39, alpha: 1.00)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
    }
}
