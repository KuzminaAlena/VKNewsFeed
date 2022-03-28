//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 17.02.2022.
//

import Foundation
import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentsViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var showTextButtonFrame: CGRect
    var attachmentsFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHight: CGFloat
}



final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {

    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width,  UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
     }

    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentsViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constans.cardInsets.left - Constans.cardInsets.right
        
        
        
        //MARK: Работа с postLabelFrame
        var postLabelFrame = CGRect(origin: CGPoint(x: Constans.postLabelInsets.left, y: Constans.postLabelInsets.top),
                                    size: CGSize.zero )
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth -  Constans.postLabelInsets.left - Constans.postLabelInsets.right
            var height = text.height(width: width, font: Constans.postLabelFont)
            let limitHeight = Constans.postLabelFont.lineHeight * Constans.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constans.postLabelFont.lineHeight * Constans.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Работа с showTextButtonFrame
        
        var showTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            showTextButtonSize = Constans.showTextButtonSize
        }
        
        let showTextButtonOrigin = CGPoint(x: Constans.showTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let showTextButtonFrame = CGRect(origin: showTextButtonOrigin, size: showTextButtonSize)
        
        //MARK: Работа с attachmentsFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constans.postLabelInsets.top : showTextButtonFrame.maxY + Constans.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                      size: CGSize.zero)

        if let attachment = photoAttachments.first {
            let ratio = CGFloat(Float(attachment.height) / Float(attachment.width))
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio )
            } else if photoAttachments.count > 1 {
                
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                let rowHeight = CustomLayout.rowHeighCalculator(superViewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
        }
        
        //MARK: Работа с bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY )
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constans.bottomViewHeight))
        
        //MARK: Работа с totalHight
        
        let totalHight = bottomViewFrame.maxY + Constans.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     showTextButtonFrame: showTextButtonFrame ,
                     attachmentsFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHight: totalHight)
    }
}
