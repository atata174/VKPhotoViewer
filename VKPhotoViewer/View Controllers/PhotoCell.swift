//
//  PhotoCell.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 27.07.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var albumImage: ImageViewManager = {
        let image = ImageViewManager()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    } ()
    
    var spinnerView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinnerView = showSpinner(in: self)
        layoutSubviews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        self.addSubview(albumImage)
        self.addSubview(spinnerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frameWidth = contentView.frame.size.width
        
        albumImage.frame = CGRect(
            x: 0,
            y: 0,
            width: frameWidth,
            height: frameWidth)

    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }
}
