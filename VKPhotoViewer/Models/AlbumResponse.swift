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
    var items: [AlbumItem]
}

struct AlbumItem: Decodable {
    var date: Int
    var sizes: [Photo]
}

struct Photo: Decodable {
    var url: String
}
