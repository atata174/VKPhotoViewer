//
//  PhotoConfigurator.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 01.08.2021.
//

import Foundation

class PhotoConfigurator {
    
    static let shared = PhotoConfigurator()
    
    private init() {}
    
    func configure(with viewController: PhotoViewController) {
        let interactor = PhotoInteractor()
        let presenter = PhotoPresenter()
        let router = PhotoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
