//
//  CatImagesScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

struct CatImageScreen: View {
    @Binding var favorites: [CatImageViewModel]
    
    @State private var catImages: [CatImageViewModel] = []
    @State private var didFirstLoad: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("可愛貓咪")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("換一批") { Task { await loadRandomImages() } }
                    .buttonStyle(.bordered)
                    .font(.headline)
            }.padding(.horizontal)
            
            ScrollView {
                ForEach(catImages) { catImage in
                    let isFavourited = favorites.contains(where: \.id == catImage.id)
                    CatImageView(catImage, isFavourited: isFavourited) {
                        toggleFavorite(catImage)
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
        // TODO: fetch new images
        try! await Task.sleep(for: .seconds(1))
        catImages = .stub.shuffled()
    }
    
    func toggleFavorite(_ cat: CatImageViewModel) {
        guard let index = favorites.firstIndex(where: \.id == cat.id)  else {
            add(cat)
            return
        }
        remove(index: index)
    }
}


private extension CatImageScreen {
    func add(_ cat: CatImageViewModel) {
        favorites.append(cat)
        // TODO: send update to the server
    }
    
    func remove(index: Int) {
        favorites.remove(at: index)
        // TODO:  send update to the server
    }
}


struct CatImageScreen_Previews: PreviewProvider, View {
    @State private var favorites: [CatImageViewModel] = []
    
    var body: some View {
        CatImageScreen(favorites: $favorites)
    }
    
    static var previews: some View {
        Self()
    }
}
