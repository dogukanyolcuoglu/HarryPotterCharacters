//
//  CharacterDetailsCoordinator.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 24.08.2021.
//

import UIKit

final class CharacterDetailsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var data: Character?
    var parentCoordinator: CharacterListCoordinator?
    
    init(data: Character, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.data = data
    }

    func start() {
        navigationController.delegate = self
        let characterDetailsVC = CharacterDetailsViewController.instantiate()
        let characterDetailsViewModel = CharacterDetailsViewModel(character: data!)
        characterDetailsViewModel.coordinator = self
        characterDetailsVC.viewModel = characterDetailsViewModel
        navigationController.pushViewController(characterDetailsVC, animated: true)
    }
    
    func didTapFavoriteAction() {
        parentCoordinator?.updateListScreen()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        } else {
            parentCoordinator?.childDidFinish(self)
        }
    }
    
    
}

