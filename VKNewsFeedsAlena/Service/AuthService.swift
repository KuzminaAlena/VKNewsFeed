//
//  AuthService.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 09.01.2022.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}


final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    static let shared = AuthService()
   
    private let appID = "8046123"
    private let vkSDK: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken().accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken().userId
    }
    
    private override init() {
        vkSDK = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    

    
    func wakeUpSession() {
        let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate]  (state, error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print( "authorized")
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
                print("auth problems, state \(state) error \(String(describing: error))")
            }
        }
    }
    
    // MARK: VKSdkDelegate

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }
    
    // MARK: VkSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
 
