//
//  HomeService.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

enum HomeServiceResult {
    case success(CreditScoreModel)
    case failure(Error)
}

final class HomeService {
    
    private let client: URLSessionHTTPClient = URLSessionHTTPClient()
    private let mockCreditEndpoint = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    
    func getDataFromEndPoint(completion: @escaping (HomeServiceResult) -> Void) {
        let url = URL(string: mockCreditEndpoint)!
        
        client.get(url: url) { (results) in
            switch results {
            case let .success(data, _):
                do {
                    let scoreObject = try self.parseJSONData(jsonData: data)
                    completion(.success(scoreObject))
                } catch let error {
                    completion(.failure(error))
                }
                
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func parseJSONData(jsonData: Data) throws -> CreditScoreModel {
        do {
            let scoreObject = try JSONDecoder().decode(CreditScoreModel.self, from: jsonData)
            return scoreObject
        } catch let error {
            throw error
        }
    }
}
