//
//  SearchService.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

class SearchService: SearchServiceProtocol {
    static let shared = SearchService()
    
    func getAppsByTitle(title: String, completion: @escaping (_ result: ItunseWrapperModel) -> Void) {
        let baseURl = "https://itunes.apple.com/search"
        guard var urlComponent = URLComponents(string: baseURl) else {
            fatalError()
        }
        
        urlComponent.queryItems = [
            URLQueryItem(name: "term", value: title),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "kr"),
            URLQueryItem(name: "limit", value: "20")
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
