//
//  HomeCoordinator.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

final class HomeCoordinator: BaseCoordinator {
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        showHomeViewController()
    }
    
    func showHomeViewController() {
        
        let viewModel = HomeViewModel(service: HomeService(), coordinator: self)
        
        let homeViewController = HomeViewController(viewModel: viewModel)
        
        router.setRootModule(homeViewController)
    }
    
    func showError(error: Error) {
        router.showErrorAlert(error: error)
    }
}
