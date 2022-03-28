//
//  WebImageView.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 13.02.2022.
//

import Foundation
import UIKit

class WebImageView: UIImageView {
    
    private var  currentURLString: String?
    
    func set(imageURL: String?) {
        
        currentURLString = imageURL
        
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { self.image = nil
            return }
        
        if let cashedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cashedResponse.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cashedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cashedResponse, for: URLRequest(url: responseURL))
        
        if responseURL.absoluteString == currentURLString {
            self.image = UIImage(data: data)        }
    }
}
