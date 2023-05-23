//
//  CatAPIManager+Endpoint.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

extension CatAPIManager {
    enum Endpoint {
        case images
        case addToFavorite(bodyData: Data)
        case favorites
        case removeFromFavorite(id: Int)
        
        var request: URLRequest {
            switch self {
                case .images:
                    return URLRequest(url: "https://api.thecatapi.com/v1/images/search?limit=10")
                case .addToFavorite(let bodyData):
                    var urlRequest = URLRequest(url: "https://api.thecatapi.com/v1/favourites")
                    urlRequest.httpMethod = "POST"
                    urlRequest.httpBody = bodyData
                    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    return urlRequest
                case .favorites:
                    // TODO: 新增頁面參數
                    return URLRequest(url: "https://api.thecatapi.com/v1/favourites")
                    
                case .removeFromFavorite(let id):
                    var urlRequest = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites/\(id)")!)
                    urlRequest.httpMethod = "DELETE"
                    return urlRequest
                    
            }
        }
    }
}
