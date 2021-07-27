//
//  NetworkManager.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 26.07.2021.
//

import Foundation

class NetworkComponents {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    private func urlComponents(path: String, parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.photosGet
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        
        var allParameters = parameters
        allParameters["access_token"] = token
        allParameters["v"] = API.version
        
        let url = self.urlComponents(path: path, parameters: allParameters)
        let request = URLRequest(url: url)
        let task = createDataTask(request: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}

struct NetworkManager {
    
    let networkComponents: NetworkComponents
    
    init(networkComponents: NetworkComponents) {
        self.networkComponents = networkComponents
    }
    
    func getAlbum(response: @escaping (AlbumResponse?) -> Void) {
        let parameters = ["album_id": "266276915", "owner_id": "-128666765"]
        
        networkComponents.request(path: API.photosGet, parameters: parameters) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(AlbumResponseWrapped.self, from: data)
                response(decoded.response)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
