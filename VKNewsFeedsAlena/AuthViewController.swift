//
//  AuthViewController.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 10.01.2022.
//

import Foundation
import UIKit


class AuthViewController: UIViewController {
    
    let authView = AuthView()
    
    private var authService = AuthService.shared

    
    override func loadView() {
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           
        authView.authButton.addTarget(self,
                                action: #selector(buttonAction),
                                for: .touchUpInside)
    }
    
    @objc
    func buttonAction() {
        authService.wakeUpSession()
    }

    
}

class AuthView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        let authButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            button.setTitle("Войти VK", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            return button
        }()
  
    private func setup() {
        addSubview(authButton)
        setupConstrains()
    } 
    private func setupConstrains() {
        authButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        authButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        authButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        authButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        authButton.translatesAutoresizingMaskIntoConstraints = false
    }
}

