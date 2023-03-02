//
//  AppEntry.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/09/14.
//

import SwiftUI

@main
struct AppEntry: App {
    
    init() {
        applyTabBarBackground()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}

extension AppEntry {
    func applyTabBarBackground() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor  = .secondarySystemBackground.withAlphaComponent(0.3)
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
