//
//  AppDelegate.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 09.01.2022.
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AuthService.shared.delegate = self
        
        window = UIWindow()
        let myVC = AuthViewController()
        let navController = UINavigationController(rootViewController: myVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    //MARK: - AuthServiceDelegate methods
    
    func authServiceShouldShow(viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print(#function)
        let feedVC = NewsFeedViewController()
        let navigationController = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navigationController
        
    } 
    
    func authServiceSignInDidFail() {
        print(#function)
    }
}

