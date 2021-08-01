//
//  AlbumConfigurator.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 01.08.2021.
//

import Foundation

class AlbumConfigurator {
    
    static let shared = AlbumConfigurator()
    
    private init() {}
    
    func configure(with viewController: AlbumViewController) {
        let interactor = AlbumInteractor()
        let presenter = AlbumPresenter()
        let router = AlbumRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
