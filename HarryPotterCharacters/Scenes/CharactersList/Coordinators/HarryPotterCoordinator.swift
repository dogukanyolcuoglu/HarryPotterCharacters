//
//  HarryPotterCoordinator.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 24.08.2021.
//

import UIKit
import Foundation

final class CharacterListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let characterListViewController = HarryPotterCharactersVC.instantiate()
        let characterListViewModel = HarryPotterCharactersViewModel()
        characterListViewModel.coordinator = self
        characterListViewController.viewModel = characterListViewModel
        navigationController.setViewControllers([characterListViewController], animated: false)
    }
    
    func startCharacterDetails() {
        let characterDetailsCoordinator = CharacterDetailsCoordinator(navigationController: navigationController)
        childCoordinators.append(characterDetailsCoordinator)
        characterDetailsCoordinator.parentCoordinator = self
        characterDetailsCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index,coordinator) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
