//
//  TitleView.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 18.03.2022.
//

import Foundation
import UIKit

protocol TitleViewModel {
    var photoURLString: String? { get }
}

class TitleView: UIView {
    
    private var searchTextField = SearchTextField()
    
    private var profilePhotosView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchTextField)
        addSubview(profilePhotosView)
        
        makeConstrains()
    }
    func set(userViewModel: TitleViewModel) {
        profilePhotosView.set(imageURL: userViewModel.photoURLString)
    }
    
    private func makeConstrains() {
        
        //profilePhotosView constrains
        profilePhotosView.anchor(top: topAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: trailingAnchor,
                                 padding: UIEdgeInsets(top: 4, left: 777, bottom: 777, right: 4))
        profilePhotosView.heightAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
        profilePhotosView.widthAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
        
        //searchTextField constrains
        searchTextField.anchor(top: topAnchor,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: profilePhotosView.leadingAnchor,
                               padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profilePhotosView.layer.masksToBounds = true
        profilePhotosView.layer.cornerRadius = profilePhotosView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
