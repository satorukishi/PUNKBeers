//
//  REST.swift
//  RM43057
//
//  Created by Satoru Kishi on 09/07/2018.
//  Copyright © 2018 Satoru Kishi. All rights reserved.
//

import Foundation

enum BeerError {
    case url
    case noResponse
    case noData
    case invalidJSON
    case taskError(error: NSError)
    case responseStatusCode(code: Int)
}

enum RESTOperation {
    case update
    case delete
    case save
}


class REST {
    
    private static let basePath = "https://api.punkapi.com/v2/beers"
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 40.0
        config.httpMaximumConnectionsPerHost = 4
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    class func loadBeers(onComplete: @escaping ([Beer]) -> Void, onError: @escaping (BeerError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                onError(.taskError(error: error! as NSError))
            } else {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    
                    guard let data = data else {
                        onError(.noData)
                        return
                    }
                    do {
                        let beers = try JSONDecoder().decode([Beer].self, from: data)
                        onComplete(beers)
                    } catch {
                        onError(.invalidJSON)
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            }
        }
        dataTask.resume()
    }
    
    class func saveBeer(_ beer: Beer, onComplete: @escaping (Bool) -> Void) {
        applyOperation(beer: beer, operation: .save, onComplete: onComplete)
    }

    class func updateBeer(_ beer: Beer, onComplete: @escaping (Bool) -> Void) {
        applyOperation(beer: beer, operation: .update, onComplete: onComplete)
    }

    class func deleteBeer(_ beer: Beer, onComplete: @escaping (Bool) -> Void) {
        applyOperation(beer: beer, operation: .delete, onComplete: onComplete)
    }

    class func applyOperation(beer: Beer, operation: RESTOperation, onComplete: @escaping (Bool) -> Void) {

        let urlString = basePath + "/" + ((beer.id == nil ? "" : "ids=" + String(describing: beer.id)))
        var httpMethod = "GET"
        switch operation {
        case .save:
            httpMethod = "POST"
        case .delete:
            httpMethod = "DELETE"
        case .update:
            httpMethod = "PUT"
        }
        guard let url = URL(string: urlString) else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = try! JSONEncoder().encode(beer)

        session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(false)
                    return
                }
                if response.statusCode == 200 {
                    onComplete(true)
                } else {
                    onComplete(false)
                }
            } else {
                onComplete(false)
            }
        }.resume()
    }
    
}

