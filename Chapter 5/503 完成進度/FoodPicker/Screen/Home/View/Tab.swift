//
//  Tab.swift
//  FoodPicker
//
//  Created by Jane Chao on 23/01/18.
//

import SwiftUI

extension HomeScreen {
    enum Tab: String, CaseIterable {
        case picker, list, settings
    }
}

extension HomeScreen.Tab: Identifiable {
    var id: Self { self }
}

extension HomeScreen.Tab: View {
    var body: some View {
        content.tabItem { tabLabel.labelStyle(.iconOnly) }
    }
    
    @ViewBuilder
    private var content: some View {
        switch self {
            case .picker: FoodPickerScreen()
            case .list: FoodListScreen()
            case .settings: SettingsScreen()
        }
    }
    
    private var tabLabel: some View {
        switch self {
            case .picker:
                return Label("Home", systemImage: .house)
            case .list:
                return Label("List", systemImage: .list)
            case .settings:
                return Label("Settings", systemImage: .gear)
        }
    }
}
