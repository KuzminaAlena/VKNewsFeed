//
//  NewsFeedCell.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 07.02.2022.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconURLString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentsViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentsFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHight: CGFloat { get }
    var showTextButtonFrame: CGRect { get  }
}

protocol FeedCellPhotoAttachmentsViewModel {
    var photoURLString: String? { get }
    var height: Int { get }
    var width: Int { get }
}

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        iconImageView?.layer.cornerRadius = iconImageView.frame.width/2
        iconImageView?.clipsToBounds = true
        
        cardView?.layer.cornerRadius = 10
        cardView?.clipsToBounds = true
        
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
//    func set(viewModel: FeedCellViewModel){
//        iconImageView.set(imageURL: viewModel.iconURLString)
//        nameLabel.text = viewModel.name
//        dateLabel.text = viewModel.date
//        postLabel.text = viewModel.text
//        likesLabel.text = viewModel.likes
//        commentsLabel.text = viewModel.comments
//        sharesLabel.text = viewModel.shares
//        viewsLabel.text = viewModel.views
//        
//        postLabel.frame = viewModel.sizes.postLabelFrame
//        postImageView.frame = viewModel.sizes.attachmentsFrame
//        bottomView.frame = viewModel.sizes.bottomViewFrame
//        
//        if let photoAttachment = viewModel.photoAttachments {
//            postImageView.set(imageURL: photoAttachment.photoURLString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//    }
}
