//
//  CatAPIManager.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

@MainActor
final class CatAPIManager: ObservableObject {
    @Published private(set) var favorites: [FavoriteItem] = []
    var getData: (Endpoint) async throws -> Data
    
    init(favorites: [FavoriteItem] = [], getData: @escaping (Endpoint) async throws -> Data) {
        self.favorites = favorites
        self.getData = getData
    }
}

// MARK: singleton
extension CatAPIManager {
    static let shared = {
        let config = URLSessionConfiguration.default
        var headers = config.httpAdditionalHeaders ?? [:]
        headers["x-api-key"] = MySecret.apiKey
        config.httpAdditionalHeaders = headers
        
        let session = URLSession(configuration: config)
        return CatAPIManager { try await session.data(for: $0.request) }
    }()
    
    static let preview = CatAPIManager(favorites: [CatImageViewModel].stub.enumerated().map { FavoriteItem(catImage: $0.element, id: $0.offset) }) {
        try? await Task.sleep(for: .seconds(1))
        return $0.stub
    }
}

// MARK: interface
extension CatAPIManager {
    func getImages() async throws -> [ImageResponse] {
        try await fetch(endpoint: .images)
    }
    
    func getFavorites() async throws {
        favorites = try await fetch(endpoint: .favorites)
    }
    
    func toggleFavorite(_ cat: CatImageViewModel) async throws {
        guard let index = favorites.firstIndex(where: \.imageID == cat.id)  else {
            try await addToFavorite(cat: cat)
            return
        }
        try await removeFromFavorite(at: index)
    }
    
    
    func addToFavorite(cat: CatImageViewModel) async throws {
        let body = ["image_id": cat.id]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        let response: FavoriteCreationResponse = try await fetch(endpoint: .addToFavorite(bodyData: bodyData))
        
        favorites.append(.init(catImage: cat, id: response.id))
    }
    
    func removeFromFavorite(id: Int) async throws {
        do {
            guard let index = favorites.firstIndex(where: \.id == id) else { return }
            try await removeFromFavorite(at: index)
        } catch URLSession.APIError.invalidCode(400) {
            // 不存在的最愛 ID，默默略過這個錯誤
        }
    }
}

// MARK: helper
private extension CatAPIManager {
    nonisolated func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        
        let data = try await getData(endpoint)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFromatter)
        
        return try decoder.decode(T.self, from: data)
    }
    
    func removeFromFavorite(at index: Int) async throws {
        do {
            let _ = try await getData(.removeFromFavorite(id: favorites[index].id))
            favorites.remove(at: index)
        } catch URLSession.APIError.invalidCode(400) {
            // 不存在的最愛 ID，默默略過這個錯誤
        }
    }
}
