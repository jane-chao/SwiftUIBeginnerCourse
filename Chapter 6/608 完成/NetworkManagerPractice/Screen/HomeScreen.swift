//
//  HomeScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var apiManager: CatAPIManager
    @State private var tab: Tab = .images
    @State private var errorMessage: String?
    
    var body: some View {
        TabView(selection: $tab) {
            CatImageScreen()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.images)
            
            FavoriteScreen()
                .tabItem { Label("Favorite", systemImage: "heart.fill") }
                .tag(Tab.favorites)
        }
        .alert(errorMessage: $errorMessage)
        .task { await loadFavorites() }
    }
}


private extension HomeScreen {
    func loadFavorites() async {
        do {
            try await apiManager.getFavorites()
        } catch {
            errorMessage = "載入最愛資料失敗"
        }
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
            .previewEnvironmentObject()
    }
}
