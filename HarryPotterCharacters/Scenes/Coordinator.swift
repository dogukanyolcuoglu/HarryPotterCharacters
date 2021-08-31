//
//  Coordinator.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 25.08.2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }

    func start()
}
