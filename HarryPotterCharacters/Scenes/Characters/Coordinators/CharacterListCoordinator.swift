//
//  HarryPotterCoordinator.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 24.08.2021.
//

import UIKit
import Foundation

final class CharacterListCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let characterListViewController = CharacterListViewController.instantiate()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let characterListViewModel = CharacterListViewModel()
        characterListViewModel.coordinator = self
        characterListViewController.viewModel = characterListViewModel
        navigationController.setViewControllers([characterListViewController], animated: false)
    }
    
    func startCharacterDetails(data: Character) {
        let characterDetailsCoordinator = CharacterDetailsCoordinator(data: data, navigationController: navigationController)
        childCoordinators.append(characterDetailsCoordinator)
        characterDetailsCoordinator.parentCoordinator = self
        characterDetailsCoordinator.start()
    }
    
    func updateListScreen() {
        characterListViewController.reloadFavoritesClosure()
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
