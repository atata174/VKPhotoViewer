//
//  PhotoCell.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 27.07.2021.
//

import UIKit

protocol CellModelRepresentable {
    var cellModel: CellIdentifiable? { get set }
}

class PhotoCell: UICollectionViewCell, CellModelRepresentable {
    
    var cellModel: CellIdentifiable? {
        didSet {
            updateViews()
            spinnerView.stopAnimating()
        }
    }
    
    private func updateViews() {
        guard let cellModel = cellModel as? PhotoCellViewModel else { return }
        guard let url = cellModel.imageUrl else { return }
        photoItem.fetchImage(from: url)
    }
    
    var photoItem: ImageViewManager = {
        let image = ImageViewManager()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    } ()
    
    var spinnerView: UIActivityIndicatorView! = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinnerView.center = contentView.center
        layoutSubviews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.addSubview(photoItem)
        self.addSubview(spinnerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frameWidth = contentView.frame.size.width
        
        photoItem.frame = CGRect(
            x: 0,
            y: 0,
            width: frameWidth,
            height: frameWidth)
    }
}
