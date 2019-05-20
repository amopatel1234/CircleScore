//
//  URLSessionHTTPClient.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping (HTTPResults) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            }
        }.resume()
    }
}
