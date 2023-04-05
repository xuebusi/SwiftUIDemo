//
//  ApiManager.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/26.
//

import Foundation

struct ApiManager {
    public static let shared = ApiManager()
    let decoder = JSONDecoder()
    
    
    public enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    
    public func getJson(url: String,
                         params: [String: String]?,
                         completionHandler: @escaping (Result<String, APIError>) -> Void) {
        let queryURL = url
        guard let url = URL(string: queryURL) else {
            debugPrint("error url: \(queryURL)")
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        debugPrint(components.url!)
        var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            // 转成JSON字符串
            let jsonString = String(data: data, encoding: .utf8) ?? ""
            DispatchQueue.main.async {
                completionHandler(.success(jsonString))
            }
        }
        task.resume()
    }
}
