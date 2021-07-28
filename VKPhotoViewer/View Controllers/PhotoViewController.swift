//
//  PhotoViewController.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 28.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photoImageView: ImageViewManager = {
        let image = ImageViewManager()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    } ()
    
    var navigationTitle: String? {
        didSet {
            title = navigationTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        layoutSubviews()
    }
    
    private func setupNavBar(){
        
        let shareButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(shareAction))
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backAction))
        
        shareButton.tintColor = .black
        backButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = shareButton
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc func shareAction() {
        print("share")
    }
    
    @objc func backAction() {
        dismiss(animated: true)
    }
    
    func layoutSubviews() {
        
        view.addSubview(photoImageView)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
 

    }
}
