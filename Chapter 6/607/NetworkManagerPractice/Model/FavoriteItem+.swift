//
//  FavoriteItem+.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

extension [FavoriteItem] {
    mutating func add(_ cat: CatImageViewModel, apiManager: CatAPIManager) async throws {
        let id = try await apiManager.addToFavorite(imageID: cat.id)
        self.append(.init(catImage: cat, id: id))
    }
    
    mutating func remove(at index: Int, apiManager: CatAPIManager) async throws {
        try await apiManager.removeFromFavorite(id: self[index].id)
        self.remove(at: index)
    }
}
