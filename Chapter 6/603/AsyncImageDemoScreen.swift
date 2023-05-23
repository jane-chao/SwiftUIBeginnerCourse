//
//  AsyncImageDemoScreen.swift
//  FoodPicker
//
//  Created by Jane Chao on 2023/3/17.
//

import SwiftUI

extension URLSession {
    static let imageSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .imageCache
        
        return .init(configuration: config)
    }()
}

extension URLCache {
    static let imageCache: URLCache = {
        .init(memoryCapacity: 20 * 1024 * 1024,
              diskCapacity: 30 * 1024 * 1024)
    }()
}


struct MyAsyncImage: View {
    @State private var phase: AsyncImagePhase
    let urlRequest: URLRequest
    var session: URLSession = .imageSession
    
    init(url: URL, session: URLSession = .imageSession) {
        self.session = session
        self.urlRequest = URLRequest(url: url)
        
        if let data = session.configuration.urlCache?.cachedResponse(for: urlRequest)?.data,
           let uiImage = UIImage(data: data) {
            _phase = .init(wrappedValue: .success(.init(uiImage: uiImage)))
        } else {
            _phase = .init(wrappedValue: .empty)
        }
    }
    
    var body: some View {
        Group {
            switch phase {
                case .empty:
                    ProgressView().scaleEffect(3)
                        .task { await load() }
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure:
                    Text("圖片無法顯示")
                @unknown default:
                    fatalError("This has not been implemented.")
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func load() async {
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode,
                  let uiImage = UIImage(data: data)
            else {
                throw URLError(.unknown)
            }
            
            phase = .success(.init(uiImage: uiImage))
        } catch {
            phase = .failure(error)
        }
    }
}


struct AsyncImageDemoScreen: View {
    @State private var id: UUID = UUID()
    let url = URL(string: "https://images.unsplash.com/photo-1678880032033-d954b408963c")!
    
    var body: some View {
        VStack {
            titleView
            MyAsyncImage(url: url).id(id)
                .frame(height: 300)
            
            Button("重新整理") {
                id = UUID()
            }

        }
    }
}

extension AsyncImageDemoScreen {
    var titleView: some View {
        Text("AsyncImage Demo")
            .font(.largeTitle.bold())
    }
}


struct AsyncImageDemoScreen_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageDemoScreen()
    }
}
