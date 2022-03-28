//
//  NetworkDataFetcher.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 06.02.2022.
//

import Foundation

protocol DataFetcher {
    func getFeed(oldNews: String?, response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(oldNews: String?, response: @escaping (FeedResponse?) -> Void) {
        var params = [ "filters" : "post, photo"]
        params["start_from "] = oldNews
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        
        guard let userId = AuthService.shared.userId else { return }
        let params = ["user_ids" : userId, "fields" : "photo_100"]
        networking.request(path: API.user, params: params) { data, error in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
        
    }
    
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil}
        return response
    }
    
}
