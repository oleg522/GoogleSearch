//
//  APIService.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation

class APIService: API {
    
    var token = Bundle.main.object(forInfoDictionaryKey: "GoogleApiKey") as? String
    
    private var tempMockService = APIMockService()
    
    init() {
    }
    
    func searchBooks(req: APISearchBooksRequest, completion: @escaping (SearchBooksResult) -> Void) {
        
        guard let token = token else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.googleapis.com"
        urlComponents.path = "/books/v1/" + "volumes"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: req.text),
            URLQueryItem(name: "key", value: token)
        ]
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                completion(.failure(APIError(message: error.localizedDescription)))
                return
            }
            
            guard let data = data else { return }
            
            if let parsedResult: Books = try? JSONDecoder().decode(Books.self, from: data) {
            completion(.success(parsedResult))
            } else if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let error = json["error"] as? [String: Any], let message = error["message"] as? String  {
                completion(.failure(APIError(message: message)))
            }
            
        })
        
        task.resume()
    }
}
