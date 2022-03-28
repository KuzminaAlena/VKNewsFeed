//
//  NewsFeedPresenter.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 06.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(feed: let feed, let revealedPostId):
            
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostId: revealedPostId)
            }
            
            let footerTitle = String.localizedStringWithFormat(NSLocalizedString("newsfeed cells count", comment: ""),  cells.count)
            
            let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
            
        case .presentUserInfo(user: let user):
            let userViewModel = UserViewModel.init(photoURLString: user?.photo100)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.dasplayUser(userViewModel: userViewModel))
            
        case .presentFooterLoader:
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayFooterLoader)
        }
    }
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostId: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSizesPost = revealedPostId.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        let sizes =  cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSizesPost)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconURLString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formatNumber(feedItem.likes?.count),
                                       comments: formatNumber(feedItem.comments?.count),
                                       shares: formatNumber(feedItem.reposts?.count),
                                       views: formatNumber(feedItem.views?.count),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes)
    }
    
    private func formatNumber(_ number: Int?) -> String? {
        guard let number = number, number > 0 else { return nil }
        var numberString = String(number)
        if 4...6 ~= numberString.count {
            numberString = String(numberString.dropLast(3)) + "K"
        } else if numberString.count > 6 {
            numberString = String(numberString.dropLast(3)) + "M"
        }

        return numberString
    }
    
    private func profile( for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourseId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresenatable = profilesOrGroups.first { (myProfileRepresenatable) -> Bool in
            myProfileRepresenatable.id == normalSourseId
        }
        return profileRepresenatable!
    }
    
//    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
//        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
//            attachment.photo
//        }), let firstPhoto = photos.first else  {
//            return nil
//        }
//        return FeedViewModel.FeedCellPhotoAttachment.init(photoURLString: firstPhoto.srcBIG, height: firstPhoto.height, width: firstPhoto.width)
//    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return  FeedViewModel.FeedCellPhotoAttachment.init(photoURLString: photo.srcBIG,
                                                               height: photo.height,
                                                               width: photo.width)
        }
    }
}
