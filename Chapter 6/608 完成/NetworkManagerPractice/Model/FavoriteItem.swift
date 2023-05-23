//
//  FavoriteItem.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

struct FavoriteItem: Decodable {
    let id: Int
    let imageID: String
    let createdAt: Date
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case imageID = "image_id"
        case createdAt = "created_at"
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container[.id]
        self.imageID = try container[.imageID]
        self.createdAt = try container[.createdAt]
        
        let imageContainer = try container.nestedContainer(key: .image)
        self.imageURL = try imageContainer["url"]
    }
    
    init(catImage: CatImageViewModel, id: Int) {
        self.id = id
        self.imageID = catImage.id
        self.createdAt = .now
        self.imageURL = catImage.url
    }
}

extension FavoriteItem: Equatable { }
