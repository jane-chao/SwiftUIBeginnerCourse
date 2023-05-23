//
//  CatImageViewModel.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import Foundation

struct CatImageViewModel: Identifiable {
    let id: String
    let url: URL
    let width: CGFloat?
    let height: CGFloat?
}

extension CatImageViewModel {
    init(_ image: CatAPIManager.ImageResponse) {
        self.init(id: image.id, url: image.url, width: image.width, height: image.height)
    }
    
    init(favoriteItem: FavoriteItem) {
        self.init(id: favoriteItem.imageID, url: favoriteItem.imageURL, width: nil, height: nil)
    }
}

extension CatImageViewModel: Equatable { }

extension [CatImageViewModel] {
    static let stub: [CatImageViewModel] = [
        .init(id: "2f6", url: "https://cdn2.thecatapi.com/images/2f6.jpg", width: 500, height: 375),
        .init(id: "MTg2ODgwOA", url: "https://cdn2.thecatapi.com/images/MTg2ODgwOA.jpg", width: 815, height: 848),
        .init(id: "MTYzOTc2NQ", url: "https://cdn2.thecatapi.com/images/MTYzOTc2NQ.jpg", width: 500, height: 750),
    ]
}
