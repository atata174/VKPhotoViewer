//
//  AuthService.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 26.07.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSighInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7910742"
    private let vkSdk: VKSdk
    private let scope = ["offline"]
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        wakUpSession()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakUpSession() {
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize(self.scope)
            case .authorized:
                print("authorized")
                self.delegate?.authServiceSignIn()
            default:
                self.delegate?.authServiceSighInDidFail()
                fatalError("Ошибка при авторизации: " + error!.localizedDescription)
            }
        }
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        } else if result.error != nil {
            print("Пользователь отменил авторизацию или произошла ошибка: " + result.error.localizedDescription)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSighInDidFail()
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
