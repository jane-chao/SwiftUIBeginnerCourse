//
//  CatAPIManager.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import Foundation

final class CatAPIManager {
    var getData: (URLRequest) async throws -> Data
    
    static let shared = {
        let session = URLSession(configuration: .default)
        return CatAPIManager(getData: session.data)
    }()
    
    static let stub = CatAPIManager { _ in
        return Data("""
[
{
"id": "1co",
"url": "https://cdn2.thecatapi.com/images/1co.png",
"width": 768,
"height": 1024
},
{
"id": "1no",
"url": "https://cdn2.thecatapi.com/images/1no.jpg",
"width": 500,
"height": 333
},
{
"id": "4gj",
"url": "https://cdn2.thecatapi.com/images/4gj.gif",
"width": 500,
"height": 287
},
{
"id": "a71",
"url": "https://cdn2.thecatapi.com/images/a71.jpg",
"width": 560,
"height": 732
},
{
"id": "b2r",
"url": "https://cdn2.thecatapi.com/images/b2r.png",
"width": 426,
"height": 640
},
{
"id": "MTUzNDkzMw",
"url": "https://cdn2.thecatapi.com/images/MTUzNDkzMw.jpg",
"width": 625,
"height": 469
},
{
"id": "MTc1NTM2OQ",
"url": "https://cdn2.thecatapi.com/images/MTc1NTM2OQ.gif",
"width": 350,
"height": 146
},
{
"id": "MTk3ODQ2NQ",
"url": "https://cdn2.thecatapi.com/images/MTk3ODQ2NQ.jpg",
"width": 640,
"height": 487
},
{
"id": "yFwzO96ds",
"url": "https://cdn2.thecatapi.com/images/yFwzO96ds.jpg",
"width": 1200,
"height": 776
},
{
"id": "0Vz3XgaPM",
"url": "https://cdn2.thecatapi.com/images/0Vz3XgaPM.jpg",
"width": 1600,
"height": 1065
}
]
""".utf8)
    }
    
    private init(getData: @escaping (URLRequest) async throws -> Data) {
        self.getData = getData
    }
}

extension CatAPIManager {
    func getImages() async throws -> [ImageResponse] {
        let data = try await getData(URLRequest(url: "https://api.thecatapi.com/v1/images/search?limit=10"))
        return try JSONDecoder().decode([ImageResponse].self, from: data)
    }
}

extension CatAPIManager {
    struct ImageResponse: Decodable {
        let id: String
        let url: URL
        let width, height: CGFloat
    }
}
