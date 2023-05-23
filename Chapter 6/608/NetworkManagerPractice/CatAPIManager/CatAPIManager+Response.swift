//
//  CatAPIManager+Response.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

extension CatAPIManager {
    struct ImageResponse: Decodable {
        let id: String
        let url: URL
        let width, height: CGFloat
    }
    
    
    struct FavoriteCreationResponse: Decodable {
        let id: Int
    }
}
