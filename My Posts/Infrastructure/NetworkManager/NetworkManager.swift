//
//  NetworkManager.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation

enum NetworkError: Error {
    
    case invalidUrl
    case invalidData
}

class NetworkManager {
    
    var urlComponents: URLComponents {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        return urlComponents
    }
    
    func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion?(nil, NetworkError.invalidData)
                return
            }
            
            guard let data = data else {
                completion?(nil, NetworkError.invalidData)
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
            
        }
        dataTask.resume()
    }
}
