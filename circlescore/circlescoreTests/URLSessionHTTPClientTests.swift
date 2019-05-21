//
//  URLSessionHTTPClientTests.swift
//  circlescoreTests
//
//  Created by Amish Patel on 21/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
@testable import circlescore

class URLSessionHTTPClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        URLProtocolStub.registerProtocolClass()
    }
    
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.unregisterProtocolClass()
    }
    
    func test_get_loadsData() {
        URLProtocolStub.stub(data: makeData(), response: makeResponse(), error: nil)
        
        let sut = makeSUT()
        
        let exp = expectation(description: "Wait for success")
        
        sut.get(url: makeURL()) { (resutls) in
            switch resutls {
            case .success(_, _):
                exp.fulfill()
                break
            case .failure(_):
                XCTFail("Failed for receving failure when expecting success")
                break
            }
        }
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_get_failsWithError() {
        URLProtocolStub.stub(data: nil, response: nil, error: makeError())
        
        let sut = makeSUT()
        
        let exp = expectation(description: "Wait for failure")
        
        sut.get(url: URL(string: "http://someurl.com")!) { (results) in
            switch results {
            case .success(_, _):
                XCTFail("Failed for receving success when expecting failure")
                break
            case .failure(_):
                exp.fulfill()
                break
            }
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    //MARK: - Helper methods
    private func makeSUT() -> URLSessionHTTPClient {
        let sut = URLSessionHTTPClient()
        return sut
    }
}
