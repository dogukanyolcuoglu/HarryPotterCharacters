//
//  HarryPotterCharactersCell.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 4.08.2021.
//

import UIKit

final class CharacterListCell: UITableViewCell {

    // MARK: - ViewModel
    var viewModel: CharacterListCellViewModel!
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterSpecies: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    
    
    // MARK: - Other funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        setConfigureImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    
    public func configureCharacter(with viewModel: CharacterListCellViewModel) {
        // Character's datas setting
        characterName.text = "Name: \(viewModel.name)"
        characterSpecies.text = "Species: \(viewModel.species)"
        imageview.sd_setImage(with: URL(string: viewModel.image), completed: nil)
        
        // Favorites setting
        favImage.tintColor = .label
        favImage.image = UIImage(systemName: "bookmark")
        for name in viewModel.names {
            if name == viewModel.name {
                favImage.image = UIImage(systemName: "bookmark.fill")
            }
        }
    }
    
    private func setConfigureImage() {
        imageview.layer.borderWidth = 1.0
        imageview.layer.masksToBounds = false
        imageview.layer.borderColor = UIColor.black.cgColor
        imageview.layer.cornerRadius = imageview.frame.size.width/2
        imageview.clipsToBounds = true
    }
}


