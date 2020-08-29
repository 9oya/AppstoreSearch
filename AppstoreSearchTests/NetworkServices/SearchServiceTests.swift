//
//  SearchServiceTests.swift
//  AppstoreSearchTests
//
//  Created by Eido Goya on 2020/08/29.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import AppstoreSearch
import XCTest

class SearchServiceTests: XCTestCase {
    
    var mockSearchService: MockSearchService!

    override func setUpWithError() throws {
        mockSearchService = MockSearchService()
    }

    override func tearDownWithError() throws {
        mockSearchService = nil
    }

    func testSearchService_getAppsByTitle_result() {
        // given
        let title = "카카오뱅크"
        var result: ItunseWrapperModel? = nil
        let e = expectation(description: "wait")
        
        // when
        mockSearchService.getAppsByTitle(title: title) { (_result) in
            result = _result
            e.fulfill()
        }
        
        // than
        wait(for: [e], timeout: 7)
        XCTAssertGreaterThan(result?.resultCount ?? 0, 1)
        XCTAssertNotNil(result?.results)
    }
}

class MockSearchService: SearchServiceProtocol {
    static let shared = SearchService()
    
    func getAppsByTitle(title: String, completion: @escaping (_ result: ItunseWrapperModel) -> Void) {
        let baseURl = "https://itunes.apple.com/search"
        guard var urlComponent = URLComponents(string: baseURl) else {
            fatalError()
        }
        
        urlComponent.queryItems = [
            URLQueryItem(name: "term", value: title),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "kr")
        ]
        
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "GET"
        
        var dataTask: URLSessionDataTask?
        dataTask = URLSession(configuration: .default).dataTask(with: request, completionHandler: { (data, response, error) in
            defer {
                dataTask = nil
            }
            if error != nil {
                print(error.debugDescription)
            }
            
            if let data = data, let response = response as? HTTPURLResponse {
                
                if response.statusCode == 200 {
                    do {
                        let decodedData = try JSONDecoder().decode(ItunseWrapperModel.self, from: data)
                        completion(decodedData)
                    } catch let error {
                        print(error.localizedDescription)
                        return
                    }
                }
                
            }
        })
        
        dataTask?.resume()
    }
}
