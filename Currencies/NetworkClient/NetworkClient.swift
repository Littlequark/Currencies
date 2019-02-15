//
//  NetworkClient.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation



fileprivate let NetworkClientInnerQueueLabel = "NetworkClientInnerQueueLabel"
fileprivate let NetworkClientBaseURLString = "https://revolut.duckdns.org/"

class NetworkClient: NetworkClientProtocol {
    
    private let clientURLSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var innerQueue: DispatchQueue = DispatchQueue(label: NetworkClientInnerQueueLabel)
    
    func performRequrest(_ endpoint:ApiEndpoint, methodParams:[String:String]?, completion: NetworkClientCompletionBlock?) {
        performRequrest(endpoint,
                        methodParams: methodParams,
                        callBackQueue: DispatchQueue.main,
                        completion: completion)
    }
    
    func performRequrest(_ endpoint:ApiEndpoint,
                         methodParams:[String:String]?,
                         callBackQueue:DispatchQueue,
                         completion: NetworkClientCompletionBlock?) {
        innerQueue.async { [weak self] in
            self?.dataTask?.cancel()
            guard let url = self?.prepareURL(endpoint, params:methodParams) else {
                completion?(nil, nil)
                return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            self?.dataTask = self?.clientURLSession.dataTask(with: urlRequest) { data, response, error in
                defer {
                    self?.dataTask = nil
                }
                callBackQueue.async {
                    completion?(data, error)
                }
            }
            self?.dataTask?.resume()
        }
    }
    
    fileprivate func prepareURL(_ endpoint:ApiEndpoint, params:[String: String]?) -> URL? {
        var reuqestURL: URL?
        if var urlComponents = URLComponents(string: NetworkClientBaseURLString) {
            urlComponents.path = endpoint.rawValue
            urlComponents.queryItems = prepareQueryItems(params: params)
            reuqestURL = urlComponents.url
        }
        return reuqestURL
    }
    
    fileprivate func prepareQueryItems(params:[String: String]?) -> [URLQueryItem] {
        var queryItems:[URLQueryItem] = [URLQueryItem]()
        for (key, value) in params! {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        return queryItems
    }

}
