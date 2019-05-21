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
    
    private func makeError() -> Error {
        return NSError(domain: "", code: 999, userInfo: nil) as Error
    }
    
    private func makeURL() -> URL{
        return URL(string: "http://someurl.com")!
    }
    
    private func makeData() -> Data {
        return Data("any data".utf8)
    }
    
    private func makeResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    //MARK: - URLProtocol stub class
    private class URLProtocolStub: URLProtocol {
        
        private static var stub: Stub?
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error)
        }
        
        static func registerProtocolClass() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func unregisterProtocolClass() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
        }
        
        override class func canInit(with request: URLRequest) -> Bool{
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() { }
    }
}
