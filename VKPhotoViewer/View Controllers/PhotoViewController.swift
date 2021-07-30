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
        image.isUserInteractionEnabled = true
        

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
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom))
        photoImageView.addGestureRecognizer(pinch)
        
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
        guard let image = photoImageView.image else {
            print("No image found")
            return
        }
        
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, error in
            if bool {
                self.successAlert()
            }
        }
        
        present(shareController, animated: true)
    }
    
    @objc func backAction() {
        dismiss(animated: true)
    }
    
    private func successAlert() {
        let alert = UIAlertController(title: "Сохранено", message: "Изображение успешно загружено в галерею", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
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
    
    @objc private func handleZoom(recognizer: UIPinchGestureRecognizer){
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
}
