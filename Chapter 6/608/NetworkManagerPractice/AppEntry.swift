//
//  NetworkManagerPracticeApp.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import SwiftUI

@main
struct NetworkManagerPracticeApp: App {
    init() {
        applyTabBarBackground()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}

extension NetworkManagerPracticeApp {
    func applyTabBarBackground() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor  = .systemBackground.withAlphaComponent(0.3)
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
