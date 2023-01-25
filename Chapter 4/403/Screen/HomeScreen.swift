//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/12/27.
//

import SwiftUI

extension HomeScreen {
    enum Tab: View, CaseIterable {
        case picker, list, settings
        
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
}

struct HomeScreen: View {
    @State var tab: Tab = .settings
    
    var body: some View {
        TabView(selection: $tab) {
            ForEach(Tab.allCases, id: \.self) { $0 }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
