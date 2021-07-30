//
//  AlbumViewController.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 26.07.2021.
//

import UIKit
import VK_ios_sdk

private let reuseIdentifier = "Cell"

class AlbumViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager(networkComponents: NetworkComponents())
    private var albumCount = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    private var album: AlbumResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM yyyy"
        return dateFormatter
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getAlbum { (album) in
            guard let count = album?.count else { return }
            self.album = album
            self.albumCount = count
        }
        
        collectionView.backgroundColor = .white
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupNavigationBar()
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
        dismiss(animated: true) {
            VKSdk.forceLogout()
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
        
        guard let url = album?.items[indexPath.row].imgSrc else { return cell }
        cell.albumImage.fetchImage(from: url)
        cell.spinnerView.stopAnimating()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = album?.items[indexPath.row].imgSrc else { return }
        guard let datePhoto = album?.items[indexPath.row].date else { return}
        let photoVC = PhotoViewController()
        photoVC.photoImageView.fetchImage(from: url)
        
        let date = Date(timeIntervalSince1970: TimeInterval(datePhoto))
        let dateTitle = self.dateFormatter.string(from: date)
        
        photoVC.navigationTitle = dateTitle

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
