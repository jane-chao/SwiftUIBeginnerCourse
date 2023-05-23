//
//  FavoriteScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

struct FavoriteScreen: View {
    @Environment(\.apiManager) private var apiManager
    @Binding var favorites: [FavoriteItem]
    
    var body: some View {
        VStack {
            Text("我的最愛")
                .font(.largeTitle.bold())
            
            ScrollView {
                if favorites.isEmpty {
                    Text("雙擊圖片即可新增到最愛喲 😊")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(x: favorites.isEmpty ? 0 : -UIScreen.main.bounds.maxX)
                        .font(.title3)
                        .padding()
                }
                
                ForEach(Array(favorites.enumerated()), id: \.element.imageID) { index, favoriteItem in
                    CatImageView(.init(favoriteItem: favoriteItem), isFavourited: true) {
                        Task {
                            // FIXME: error handling & pass async closure??
                            try await favorites.remove(at: index, apiManager: apiManager)
                        }
                    }.transition(.slide)
                }
            }
        }.animation(.spring(), value: favorites)
    }
}


struct FavoriteScreen_Previews: PreviewProvider, View {
    @State private var favorites: [FavoriteItem] = [CatImageViewModel].stub.enumerated().map { FavoriteItem(catImage: $0.element, id: $0.offset) }
    
    var body: some View {
        FavoriteScreen(favorites: $favorites)
    }
    
    static var previews: some View {
        Self()
    }
}
