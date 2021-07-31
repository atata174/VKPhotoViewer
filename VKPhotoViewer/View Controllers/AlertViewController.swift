//
//  AlertViewController.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 31.07.2021.
//

import UIKit

public class AlertViewController: UIAlertController {
   
    private lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = AlertClearViewController()
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindow.Level.alert + 1
        return window
    }()
    
    public func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            
            rootViewController.present(self, animated: flag, completion: completion)
        }
    }
    
}

private class AlertClearViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        return ((view.window?.windowScene?.statusBarManager?.isStatusBarHidden) != nil)
    }

}
