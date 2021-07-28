//
//  AlbumViewController.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 26.07.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class AlbumViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager(networkComponents: NetworkComponents())
    private var albumCount = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    private var photosUrl: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getAlbum { (album) in
            guard let count = album?.count else { return }
            self.albumCount = count
        }
        
        collectionView.backgroundColor = .white
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupNavigationBar()
        networkOperations()
        
    }
    
    private func setupNavigationBar() {
        title = "Mobile Up Gallery"
        
        let logOutButton = UIBarButtonItem(
            title: "Выход",
            style: .plain,
            target: self,
            action: #selector(logOutAction))
        
        logOutButton.tintColor = .black
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    @objc private func logOutAction(){
        print("logout")
    }
    
    private func networkOperations(){
        networkManager.getAlbum { (album) in
            guard let album = album?.items else { return }
            self.photosUrl.append(
                contentsOf: album.map { (photos) -> String in
                    guard let url = photos.sizes.last?.url else { return ""}
                    return url
                }
            )
        }
    }
}

// MARK:- UICollectionViewDataSource

extension AlbumViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        networkManager.getAlbum { (response) in
            guard let albumResponse = response else { return }
            guard let url = albumResponse.items[indexPath.row].sizes.last?.url else { return }
            cell.albumImage.fetchImage(from: url)
            cell.spinnerView.stopAnimating()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoViewController()
        photoVC.photoImageView.fetchImage(from: photosUrl[indexPath.row])
        
        let navVC = UINavigationController(rootViewController: photoVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size:CGFloat = (collectionView.frame.size.width - 3) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}
