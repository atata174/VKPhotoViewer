//
//  SceneDelegate.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 25.07.2021.
//

import UIKit
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sceneDelegate: SceneDelegate = (((scene?.delegate as? SceneDelegate)!))
        return sceneDelegate
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        authService = AuthService()
        authService.delegate = self
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }

    // MARK: - AuthServiceDelegate
    
    func authServiceShouldShow(viewController: UIViewController) {
        let modalVC = viewController
        modalVC.modalPresentationStyle = .automatic
        window?.rootViewController?.present(modalVC, animated: true)
    }
    
    func authServiceSignIn() {
        let layout = UICollectionViewFlowLayout()
        let albumVC = AlbumViewController(collectionViewLayout: layout)
        let navVC = UINavigationController(rootViewController: albumVC)
        navVC.modalPresentationStyle = .fullScreen
        window?.rootViewController?.present(navVC, animated: true)
    }
    
    func authServiceSighInDidFail() {
        showAlert(title: "Ошибка", message: "Ошибка при авторизации или нет доступа к сети", completion: nil)
    }
    
    func showAlert(title: String, message: String,  completion: (() -> Void)? = nil) {
        let alert = AlertViewController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        window?.rootViewController?.present(alert, animated: true, completion: completion)
    }
    
}

