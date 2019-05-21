//
//  Helpers.swift
//  circlescoreTests
//
//  Created by Amish Patel on 21/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import Foundation

//MARK: - Helper methods
func makeError() -> Error {
    return NSError(domain: "", code: 999, userInfo: nil) as Error
}

func makeURL() -> URL{
    return URL(string: "http://someurl.com")!
}

func makeData() -> Data {
    return Data("any data".utf8)
}

func makeResponse() -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
}

//MARK: - URLProtocol stub class
class URLProtocolStub: URLProtocol {
    
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
