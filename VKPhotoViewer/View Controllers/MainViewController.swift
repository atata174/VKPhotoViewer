//
//  MainViewController.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 25.07.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    let galleryLink = "https://vk.com/album-128666765_266276915"
    
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var hyperlinkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainViewSetup()
    }
    
    func mainViewSetup() {
        
        // login button view
        logInButton.backgroundColor = .black
        logInButton.setTitle("Вход через VK", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.layer.cornerRadius = 10
        
        // hyperlink button view
        hyperlinkButton.setTitle("Mobile Up Gallery", for: .normal)
        hyperlinkButton.setTitleColor(.black, for: .normal)
        hyperlinkButton.titleLabel?.numberOfLines = 2
    }

}
