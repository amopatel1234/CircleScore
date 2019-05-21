//
//  HomeViewModel.swift
//  circlescore
//
//  Created by Amish Patel on 21/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func didFinishLoadingData(creditScore: Int, maxScore: Int)
    func didFailLoadingData()
    func loadingDataFromEndpoint()
}

final class HomeViewModel {
    private let service: HomeService
    private let coordinator: HomeCoordinator?
    
    weak var delegate: HomeViewModelDelegate?
    
    init(service: HomeService, coordinator: HomeCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func getDataFromEndPoint() {
        delegate?.loadingDataFromEndpoint()
        service.getDataFromEndPoint { (results) in
            switch results {
            case let .success(creditScoreModel):
                DispatchQueue.main.async {
                    self.delegate?.didFinishLoadingData(creditScore: creditScoreModel.score, maxScore: creditScoreModel.maxScore)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.delegate?.didFailLoadingData()
                    self.displayErrorToUser(error: error)
                }
            }
        }
    }
    
    func displayErrorToUser(error: Error) {
        coordinator?.showError(error: error)
    }
}
