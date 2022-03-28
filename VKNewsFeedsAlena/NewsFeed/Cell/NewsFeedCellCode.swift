//
//  NewsFeedCellCode.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 21.02.2022.
//

import Foundation
import UIKit


protocol NeewsFeedCellCodeDelegate: class {
    func revealPost(for cell: NewsFeedCellCode)
}

class NewsFeedCellCode: UITableViewCell {
    
    let reuseId = "NewsFeedCellCode"
    
    weak var delegate: NeewsFeedCellCodeDelegate?
    
    // First layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    // Second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UITextView = {
       let textView = UITextView()
        textView.font = Constans.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    lazy var showTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4012392163, green: 0.6231879592, blue: 0.8316264749, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью..", for: .normal)
        button.addTarget(self,
                         action: #selector(showTextButtonTouched),
                         for: .touchUpInside )
        
        return button
    }()

    let photosCollectionView = PhotosCollectionView()

    let postImageView: WebImageView = {
        let image = WebImageView()

        return image
    }()
    
    let bottomView: UIView = {
       let view = UIView()
        return view
    }()
    
    //Third layer on topView
    
    let iconImageView: WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    //Third layer on bottomView
    
    let likesView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //Fourth layer on bottomView
    
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "view")
        return imageView
    }()
     
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.layer.cornerRadius = Constans.topViewHeight/2
        iconImageView.clipsToBounds = true
  
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true

        //showTextButton.addAction(UIAction(handler: <#T##UIActionHandler##UIActionHandler##(UIAction) -> Void#>), for: <#T##UIControl.Event#>)
        
        firstLayerCardView() // первый слой
        secondLayer() // второй слой
        thirdLayerOnTopView() // третий слой на topView
        thirdLayerOnBottomView() // третий слой на bottomView
        fourthLayerOnBottomView() // четвертый слой на bottomView
    }
    @objc func showTextButtonTouched(){
        delegate?.revealPost(for: self)
    }
    
    func set(viewModel: FeedCellViewModel){
        
        iconImageView.set(imageURL: viewModel.iconURLString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views

        
        postLabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        showTextButton.frame = viewModel.sizes.showTextButtonFrame

        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoURLString)
            postImageView.isHidden = false
            photosCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentsFrame
        } else if viewModel.photoAttachments.count > 1 {
            photosCollectionView.frame  = viewModel.sizes.attachmentsFrame
            postImageView.isHidden = true
            photosCollectionView.isHidden = false
            photosCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            photosCollectionView.isHidden = true
        }
    }
    
    private func thirdLayerOnBottomView() {
        
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        
        likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        likesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: Constans.bottomViewHeight).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: Constans.viewBottomViewWidth).isActive = true
        
        //commentsView constrains
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        commentsView.heightAnchor.constraint(equalToConstant: Constans.bottomViewHeight).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: Constans.viewBottomViewWidth).isActive = true

        //sharesView constrains
        sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
        sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: Constans.bottomViewHeight).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: Constans.viewBottomViewWidth).isActive = true

        //viewsView constrains
        viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: Constans.bottomViewHeight).isActive = true
        viewsView.widthAnchor.constraint(equalToConstant: Constans.viewBottomViewWidth).isActive = true
        
    }
    
    private func fourthLayerOnBottomView() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)

        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        
        addConstraintsForFourthLayer(view: likesView, image: likesImage, label: likesLabel)
        addConstraintsForFourthLayer(view: commentsView, image: commentsImage, label: commentsLabel)
        addConstraintsForFourthLayer(view: sharesView, image: sharesImage, label: sharesLabel)
        addConstraintsForFourthLayer(view: viewsView, image: viewsImage, label: viewsLabel)
    }
    
    private func addConstraintsForFourthLayer(view: UIView, image: UIImageView, label: UILabel) {
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalToConstant: Constans.bottomViewViewsIconSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: Constans.bottomViewViewsIconSize).isActive = true
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func thirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        
        //iconImage constrains
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constans.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constans.topViewHeight).isActive = true
        
        //nameLabel constrains
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 4).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constans.topViewHeight / 2 - 4).isActive = true
        
        //dateLabel constrains
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -4).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: Constans.topViewHeight / 2 - 6).isActive = true
        
        
    }
    
    private func secondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(showTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(photosCollectionView)
        cardView.addSubview(bottomView)
        
        //topView constrains
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constans.topViewHeight).isActive = true
        
        //postLabel constrains
        // не нужно, так как размеры задаются динамически
        
        //showTextButton constrains
        // не нужно, так как размеры задаются динамически
        
        //postImageView constrains
        // не нужно, так как размеры задаются динамически
        
        //bottomView constrains
        // не нужно, так как размеры задаются динамически
        
    }
    
    private func firstLayerCardView() {
        
        contentView.addSubview(cardView)
        
        //cardView constrains
        cardView.fillSuperview(padding: Constans.cardInsets)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
