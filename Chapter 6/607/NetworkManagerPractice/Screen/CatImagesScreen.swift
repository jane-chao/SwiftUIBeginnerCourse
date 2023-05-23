//
//  CatImagesScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

struct CatImageScreen: View {
    @Environment(\.apiManager) private var apiManger
    @Binding var favorites: [FavoriteItem]
    
    @State private var catImages: [CatImageViewModel] = []
    @State private var didFirstLoad: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("可愛貓咪")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // FIXME: 不該等網路呼叫結束才有動畫
                Button("換一批") { Task { await loadRandomImages() } }
                    .buttonStyle(.bordered)
                    .font(.headline)
            }.padding(.horizontal)
            
            ScrollView {
                ForEach(catImages) { catImage in
                    let isFavourited = favorites.contains(where: \.imageID == catImage.id)
                    CatImageView(catImage, isFavourited: isFavourited) {
                        Task {
                            // FIXME: error handling & pass async closure??
                            try! await toggleFavorite(catImage)
                        }
                    }
                }
            }
        }
        .task {
            if !didFirstLoad {
                await loadRandomImages()
                didFirstLoad = true
            }
        }
    }
}

private extension CatImageScreen {
    func loadRandomImages() async {
        // FIXME: error handling
        catImages = (try! await apiManger.getImages()).map(CatImageViewModel.init)
    }
    
    func toggleFavorite(_ cat: CatImageViewModel) async throws {
        guard let index = favorites.firstIndex(where: \.imageID == cat.id)  else {
            try await favorites.add(cat, apiManager: apiManger)
            return
        }
        try await favorites.remove(at: index, apiManager: apiManger)
    }
}


struct CatImageScreen_Previews: PreviewProvider, View {
    @State private var favorites: [FavoriteItem] = []
    
    var body: some View {
        CatImageScreen(favorites: $favorites)
    }
    
    static var previews: some View {
        Self()
            .environment(\.apiManager, .stub)
    }
}
