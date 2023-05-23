//
//  FavoriteScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

struct FavoriteScreen: View {
    @EnvironmentObject private var apiManager: CatAPIManager
    
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("我的最愛")
                .font(.largeTitle.bold())
            
            ScrollView {
                if apiManager.favorites.isEmpty {
                    Text("雙擊圖片即可新增到最愛喲 😊")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(x: apiManager.favorites.isEmpty ? 0 : -UIScreen.main.bounds.maxX)
                        .font(.title3)
                        .padding()
                }
                
                ForEach(apiManager.favorites, id: \.imageID) { favoriteItem in
                    CatImageView(.init(favoriteItem: favoriteItem), isFavourited: true) {
                        do {
                            try await apiManager.removeFromFavorite(id: favoriteItem.id)
                        } catch {
                            errorMessage = "無法移除最愛項目"
                        }
                    }.transition(.slide)
                }
            }
        }
        .animation(.spring(), value: apiManager.favorites)
        .alert(errorMessage: $errorMessage)
    }
}


struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteScreen()
            .previewEnvironmentObject()
    }
}
