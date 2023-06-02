//
//  CatImagesScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

struct CatImageScreen: View {
    @EnvironmentObject private var apiManager: CatAPIManager
    
    @State private var catImages: [CatImageViewModel] = []
    
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
                    let isFavourited = apiManager.favorites.contains(where: \.imageID == catImage.id)
                    CatImageView(catImage, isFavourited: isFavourited) {
                        await toggleFavorite(catImage)
                    }
                }
            }
        }
        .alert(errorMessage: $errorMessage)
        .task {
            if !catImages.isEmpty { return }
            await loadRandomImages()
        }
    }
}

private extension CatImageScreen {
    func loadRandomImages() async {
        do {
            defer { isLoading = false }
            isLoading = true
            catImages = (try await apiManager.getImages()).map(CatImageViewModel.init)
        } catch {
            errorMessage = "無法載入圖片資訊"
        }
    }
    
    func toggleFavorite(_ cat: CatImageViewModel) async {
        do {
            try await apiManager.toggleFavorite(cat)
        } catch {
            errorMessage = "無法更新最愛"
        }
    }
}


struct CatImageScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatImageScreen()
            .previewEnvironmentObject(manager: .preview)
    }
}
