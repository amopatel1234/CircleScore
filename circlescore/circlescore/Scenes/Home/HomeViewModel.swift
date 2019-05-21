//
//  HomeViewModel.swift
//  circlescore
//
//  Created by Amish Patel on 21/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

final class HomeViewModel {
    private let service: HomeService
    private let coordinator: HomeCoordinator?
    
    init(service: HomeService, coordinator: HomeCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    
    func getDataFromEndPoint() {
        service.getDataFromEndPoint { (results) in
            switch results {
            case let .success(creditScoreModel):
                print(creditScoreModel.score)
                break
            case let .failure(error):
                DispatchQueue.main.async {
                    self.coordinator?.showError(error: error)
                }
                break
            }
        }
    }
    
    func displayErrorToUser(error: Error) {
        coordinator?.showError(error: error)
    }
}
