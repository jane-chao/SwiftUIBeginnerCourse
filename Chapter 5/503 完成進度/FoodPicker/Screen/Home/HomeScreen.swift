//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/12/27.
//

import SwiftUI

struct HomeScreen: View {
    @AppStorage(.shouldUseDarkMode) var shouldUseDarkMode = false
    @State var tab: Tab = {
        let rawValue = UserDefaults.standard.string(forKey: UserDefaults.Key.startTab.rawValue) ?? ""
        return Tab(rawValue: rawValue) ?? .picker
    }()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tab) {
                ForEach(Tab.allCases)
            }.preferredColorScheme(shouldUseDarkMode ? .dark : .light)
        }
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
