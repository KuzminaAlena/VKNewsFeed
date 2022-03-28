//
//  NewsFeedInteractor.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 06.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        switch request {
        case .getNewsFeed:
            service?.getFeed(complition: { [weak self] (revealPostId, feed) in
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealdedPostId: revealPostId))
            })
        case .getUser:
            service?.getUser(complition: { [weak self] (user) in
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: user))
            })
        case .revealPostId(postId: let postId):
            service?.revealPostId(forPostId: postId, complition: { [weak self] (revealPostId, feed) in
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealdedPostId: revealPostId))
            })
        case .getOldNews:
            self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentFooterLoader)
            service?.getOldNews(complition: { [weak self] (revealPostId, feed) in
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealdedPostId: revealPostId))
            })
        }

    }
}
