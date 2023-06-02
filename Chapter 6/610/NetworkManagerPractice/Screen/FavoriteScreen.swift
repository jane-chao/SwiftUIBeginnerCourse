//
//  FavoriteScreen.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

enum FavoriteLoadingState: Equatable {
    case notStarted
    case loading
    case success
    case fail
}

struct FavoriteScreen: View {
    @EnvironmentObject private var apiManager: CatAPIManager
    @State private var loadingState: FavoriteLoadingState = .notStarted
    @State private var errorMessage: String?
    
    
    var body: some View {
        VStack {
            Text("我的最愛")
                .font(.largeTitle.bold())
            
            ScrollView {
                if apiManager.favorites.isEmpty && loadingState == .success  {
                    favoriteFeatureHintText
                }
                
                favoriteList
                
                Group {
                    if loadingState == .fail {
                       retryButton
                    }
                    
                    if loadingState == .loading {
                        ProgressView()
                            .controlSize(.large)
                    }
                }.frame(minHeight: 100)
            }
        }
        .animation(.spring(), value: apiManager.favorites)
        .alert(errorMessage: $errorMessage)
        .task {
            guard loadingState == .notStarted else { return }
            await loadFavorite()
        }
    }
}

private extension FavoriteScreen {
    func loadFavorite() async {
        loadingState = .loading
        do {
            try await apiManager.getFavorites()
            loadingState = .success
        } catch {
            loadingState = .fail
        }
    }
}

// MARK: subviews
private extension FavoriteScreen {
    var favoriteFeatureHintText: some View {
        Text("雙擊圖片即可新增到最愛喲 😊")
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(x: apiManager.favorites.isEmpty ? 0 : -UIScreen.main.bounds.maxX)
            .font(.title3)
            .padding()
    }
    
    var favoriteList: some View {
        ForEach(apiManager.favorites, id: \.imageID) { favoriteItem in
            CatImageView(.init(favoriteItem: favoriteItem), isFavourited: true) {
                do {
                    try await apiManager.removeFromFavorite(id: favoriteItem.id)
                } catch {
                    errorMessage = "無法移除最愛項目，請確認網路狀態後再重試。"
                }
            }.transition(.slide)
        }
    }
    
    var retryButton: some View  {
        HStack {
            Text("載入最愛資料未完成，\n請確認網路狀態後再重試。")
            Button("繼續") {
                Task {
                    await loadFavorite()
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        }
    }
}

struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        let managerWithDefaultFavorites = CatAPIManager(getData: \.stub)
        
        FavoriteScreen()
            .previewEnvironmentObject(manager: managerWithDefaultFavorites)
    }
}
