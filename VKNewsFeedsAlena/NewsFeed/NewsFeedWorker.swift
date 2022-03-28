//
//  NewsFeedWorker.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 06.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsFeedService {
    
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedPostId = [Int]()
    private var feedResponse: FeedResponse?
    private var loadOldPosts: String?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(complition: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            complition(userResponse)
        }
    }
    
    func  getFeed(complition: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed(oldNews: nil ) { [weak self] (feed) in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else { return }
            complition(self!.revealedPostId, feedResponse)
        }
    }
    
    func revealPostId(forPostId postId: Int, complition: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostId.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        complition(revealedPostId, feedResponse)
    }
    
    func getOldNews(complition: @escaping ([Int], FeedResponse) -> Void) {
        loadOldPosts = feedResponse?.nextFrom
        fetcher.getFeed(oldNews: loadOldPosts) { [weak self] (feed) in
            guard let feed = feed else { return }
            guard self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter({ (oldProfile) -> Bool in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    })
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter({ (oldGroups) -> Bool in
                        !feed.groups.contains(where: { $0.id == oldGroups.id })
                    })
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
                
                self?.feedResponse?.nextFrom = feed.nextFrom
                
                
            }
            guard let feedResponse = self?.feedResponse else { return }
            complition(self!.revealedPostId, feedResponse)
            
        }
    }
}

