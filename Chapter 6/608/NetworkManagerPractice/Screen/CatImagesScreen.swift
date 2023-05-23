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
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            HStack {
                Text("可愛貓咪")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("換一批") { Task { await loadRandomImages() } }
                    .buttonStyle(.bordered)
                    .font(.headline)
                    .overlay {
                        if isLoading {
                            ProgressView()
                        }
                    }
                    .disabled(isLoading)
                
            }.padding(.horizontal)
            
            ScrollView {
                ForEach(catImages) { catImage in
                    let isFavourited = favorites.contains(where: \.imageID == catImage.id)
                    CatImageView(catImage, isFavourited: isFavourited) {
                        await toggleFavorite(catImage)
                    }
                }
            }
        }
        .alert(errorMessage: $errorMessage)
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
        do {
            defer { isLoading = false }
            isLoading = true
            catImages = (try await apiManger.getImages()).map(CatImageViewModel.init)
        } catch {
            errorMessage = "無法載入圖片資訊"
        }
    }
    
    func toggleFavorite(_ cat: CatImageViewModel) async {
        do {
            guard let index = favorites.firstIndex(where: \.imageID == cat.id)  else {
                try await favorites.add(cat, apiManager: apiManger)
                return
            }
            try await favorites.remove(at: index, apiManager: apiManger)
        } catch {
            errorMessage = "無法更新最愛"
        }
    }
}


struct CatImageScreen_Previews: PreviewProvider, View {
    @State private var favorites: [FavoriteItem] = []
    
    var body: some View {
        CatImageScreen(favorites: $favorites)
    }
    
    static var previews: some View {
        Self()
            .environment(\.apiManager, .preview)
    }
}
