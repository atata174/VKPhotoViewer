//
//  AlbumResponse.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 26.07.2021.
//

import Foundation

struct AlbumResponseWrapped: Decodable {
    var response: AlbumResponse?
}

struct AlbumResponse: Decodable {
    var count: Int
    var items: [Photo]
}

struct Photo: Decodable {
    var date: Int
    var sizes: [PhotoSizes]
    var imgSrc: String {
        self.getSize().url
    }
    
    private func getSize() -> PhotoSizes{
        if let sizeX = sizes.first(where: { $0.type == "x"}) {
            return sizeX
        } else if let bigSize = sizes.last {
            return bigSize
        } else {
            return PhotoSizes(type: "wrong type", url: "wrong url")
        }
    }
}

struct PhotoSizes: Decodable {
    var type: String
    var url: String
}
