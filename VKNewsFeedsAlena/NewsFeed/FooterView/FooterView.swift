//
//  BottomView.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 21.03.2022.
//

import Foundation
import UIKit

class FooterView: UIView {
    
    private var bottomLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.6319127679, green: 0.6468527317, blue: 0.664311111, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loadIndicator: UIActivityIndicatorView = {
       let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        return ai
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bottomLabel)
        addSubview(loadIndicator)
        
        
        bottomLabel.anchor(top: topAnchor,
                       leading: leadingAnchor,
                       bottom: nil,
                       trailing: trailingAnchor,
                       padding: UIEdgeInsets(top: 8, left: 20, bottom: 777, right: 20))
        
        loadIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadIndicator.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func showLoader() {
        loadIndicator.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        loadIndicator.stopAnimating()
        bottomLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
