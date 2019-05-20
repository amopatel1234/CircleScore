//
//  BaseCoordinator.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func start() {
        
    }
}
