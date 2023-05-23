//
//  FavoriteScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

struct FavoriteScreen: View {
    @Binding var favorites: [CatImageViewModel]
    
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
                
                ForEach(Array(favorites.enumerated()), id: \.element.id) { index, catImage in
                    CatImageView(catImage, isFavourited: true) {
                        // TODO:  send update to the server
                        favorites.remove(at: index)
                    }.transition(.slide)
                }
            }
        }.animation(.spring(), value: favorites)
    }
}


struct FavoriteScreen_Previews: PreviewProvider, View {
    @State private var favorites: [CatImageViewModel] = .stub
    var body: some View {
        FavoriteScreen(favorites: $favorites)
    }
    
    static var previews: some View {
        Self()
    }
}
