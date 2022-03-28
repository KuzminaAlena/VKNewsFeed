//
//  NetworkService.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 02.02.2022.
//

import Foundation
import UIKit

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}


final class NetworkService: Networking {

    
    // https://api.vk.com/method/users.get?user_id=210700286&v=5.131
    
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = AuthService.shared.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: {(data, responce, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        } )
    }
    
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
}
