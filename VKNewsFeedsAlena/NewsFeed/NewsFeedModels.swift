//
//  NewsFeedModels.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 06.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case getUser
                case revealPostId(postId: Int)
                case getOldNews
            }
        }
    struct Response {
      enum ResponseType {
          case presentNewsFeed(feed: FeedResponse, revealdedPostId: [Int])
          case presentUserInfo(user: UserResponse?)
          case presentFooterLoader
      }
    }
    struct ViewModel {
      enum ViewModelData {
          case displayNewsFeed(feedViewModel: FeedViewModel)
          case dasplayUser(userViewModel: UserViewModel)
          case displayFooterLoader
      }
    }
  }
  
}

struct UserViewModel: TitleViewModel {
    var photoURLString: String?
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int
        var iconURLString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentsViewModel]
        var sizes: FeedCellSizes
    }
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentsViewModel{
        var photoURLString: String?
        var height: Int
        var width: Int
    }
    let cells: [Cell]
    let footerTitle: String?
}
