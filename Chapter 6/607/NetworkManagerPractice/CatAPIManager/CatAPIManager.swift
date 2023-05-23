//
//  CatAPIManager.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

final class CatAPIManager {
    var getData: (Endpoint) async throws -> Data
    
    static let shared = {
        let config = URLSessionConfiguration.default
        var headers = config.httpAdditionalHeaders ?? [:]
        headers["x-api-key"] = MySecret.apiKey
        config.httpAdditionalHeaders = headers
        
        let session = URLSession(configuration: config)
        return CatAPIManager { try await session.data(for: $0.request) }
    }()
    
    static let stub = CatAPIManager { $0.stub }
    
    private init(getData: @escaping (Endpoint) async throws -> Data) {
        self.getData = getData
    }
}

extension CatAPIManager {
    func getImages() async throws -> [ImageResponse] {
        try await fetch(endpoint: .images)
    }
    
    func getFavorites() async throws -> [FavoriteItem] {
        try await fetch(endpoint: .favorites)
    }
    
    
    func addToFavorite(imageID: String) async throws -> Int  {
        let body = ["image_id": imageID]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let response: FavoriteCreationResponse = try await fetch(endpoint: .addToFavorite(bodyData: bodyData))
        
        return response.id
    }
    
    func removeFromFavorite(id: Int) async throws {
        let _ = try await getData(.removeFromFavorite(id: id))
    }
}

private extension CatAPIManager {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        
        let data = try await getData(endpoint)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFromatter)
        
        return try decoder.decode(T.self, from: data)
    }
}
