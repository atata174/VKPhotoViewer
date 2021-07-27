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
        image.backgroundColor = .systemBlue
        return image
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutSubviews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        self.backgroundColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1)
        self.addSubview(albumImage)
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
}
