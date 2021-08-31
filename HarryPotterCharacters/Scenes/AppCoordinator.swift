//
//  AppCoordinator.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 24.08.2021.
//

import UIKit
import Foundation

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators = [Coordinator]()
   
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let characterListCoordinator = CharacterListCoordinator(navigationController: navigationController)
        childCoordinators.append(characterListCoordinator)
        characterListCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
