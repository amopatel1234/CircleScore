//
//  HTTPClient.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

enum HTTPResults {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

protocol HTTPClient {
    func get(url: URL, completion: @escaping (HTTPResults) -> Void)
}
