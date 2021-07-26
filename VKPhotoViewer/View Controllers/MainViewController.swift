//
//  MainViewController.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 25.07.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let galleryLink = "https://vk.com/album-128666765_266276915"
    private var authService: AuthService!
    
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var hyperlinkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        authService = SceneDelegate.shared().authService
        
        mainViewSetup()
    }
    
    @IBAction func logInActionButton(_ sender: UIButton) {
        authService.wakUpSession()
    }
    
    func mainViewSetup() {
        
        // login button view
        logInButton.backgroundColor = .black
        logInButton.setTitle("Вход через VK", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.layer.cornerRadius = 10
        
        // hyperlink button view
        hyperlinkButton.setTitle("Mobile Up \nGallery", for: .normal)
        hyperlinkButton.setTitleColor(.black, for: .normal)
        hyperlinkButton.titleLabel?.numberOfLines = 2
    }
    
}
