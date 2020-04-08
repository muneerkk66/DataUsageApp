//
//  DataUsageMockResponse.swift
//  MobileDataUsageAppTests
//
//  Created by x218507 on 05/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
import UIKit
@testable import MobileDataUsageApp

class MockDataProvider: NSObject {
   let mobileData = MobileDataUsage(year: 2010, mobileData: 10.12345, quarter: nil, hasDecremented: true)
   var mockAPIResponse : DataUsageAPIResponse?
    
  func loadMockAPIResponse(){
        if let path = Bundle(for: type(of: self)).path(forResource: "MockAPIResponse", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let dataUsageResponse = try JSONDecoder().decode(DataUsageAPIResponse.self, from: data)
                  mockAPIResponse = dataUsageResponse
              } catch {
                   // handle error
              }
        }
    }
    
    func getURlpath()->String? {
        guard var components = URLComponents(string: AppConstants.baseURL + AppConstants.APIUrls.dataUsage.rawValue) else {
                   return nil
               }
               let queryItem = URLQueryItem(name: AppConstants.URLQUERY.resource_id.rawValue, value: AppConstants.resourceID)
               components.queryItems = [queryItem]
               guard let urlpath = components.string else {
                   return nil
               }
        return urlpath
    }
}

class MockURLProtocol: URLProtocol {
    
    enum ResponseType {
        case error(Error)
        case success(HTTPURLResponse)
    }
    static var responseType: ResponseType!
    
    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    private(set) var activeTask: URLSessionTask?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
}

// MARK: - URLSessionDataDelegate
extension MockURLProtocol: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch MockURLProtocol.responseType {
        case .error(let error)?:
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let response)?:
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        default:
            break
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
}

extension MockURLProtocol {
    
    enum MockError: Error {
        case none
    }
    
    static func responseWithFailure() {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(MockError.none)
    }
    
    static func responseWithStatusCode(code: Int) {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(HTTPURLResponse(url: URL(string: AppConstants.baseURL)!, statusCode: code, httpVersion: nil, headerFields: nil)!)
    }
}
