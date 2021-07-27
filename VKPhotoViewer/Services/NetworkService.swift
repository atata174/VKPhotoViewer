//
//  NetworkManager.swift
//  VKPhotoViewer
//
//  Created by PenguinRaja on 26.07.2021.
//

import Foundation

protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
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

protocol DataFetcher {
    func getAlbum(response: @escaping (AlbumResponse?) -> Void)
}

struct NetworkManager: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getAlbum(response: @escaping (AlbumResponse?) -> Void) {
        let parameters = ["album_id": "266276915", "owner_id": "-128666765"]
        
        networking.request(path: API.photosGet, parameters: parameters) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }

            let decoded = self.decodeJSON(type: AlbumResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        guard let data = from, let response = try? JSONDecoder().decode(type.self, from: data) else { return nil }
        return response
    }
    
    
    
    
}
