//
//  HomeScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

// FIXME: Better implementation for handling favorites.
struct HomeScreen: View {
    @State private var tab: Tab = .images
    @State private var favoriteImages: [CatImageViewModel] = []
    
    var body: some View {
        TabView(selection: $tab) {
            CatImageScreen(favorites: $favoriteImages)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.images)
            
            FavoriteScreen(favorites: $favoriteImages)
                .tabItem { Label("Favorite", systemImage: "heart.fill") }
                .tag(Tab.favorites)
        }
        .task {
            // FIXME: error handling
            try! await loadFavorites()
        }
    }
}


private extension HomeScreen {
    func loadFavorites() async throws {
        // TODO: fetch favorite
    }
}


private extension HomeScreen {
    enum Tab {
        case images, favorites
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
