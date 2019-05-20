//
//  AppCoordinator.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        runHomeFlow()
    }
    
    func runHomeFlow() {
        let coordinator = HomeCoordinator(router: router)
        
        coordinator.start()
        addChildCoordinator(coordinator)
    }
}
