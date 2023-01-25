//
//  SettingsScreen.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/12/28.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

private enum Dialog: String {
    case resetSettings = "重置設定"
    case resetFoodList = "重置食物紀錄"
    case inactive
    
    var message: String {
        switch self {
            case .resetSettings:
                return "將重置顏色、單位等設置，\n此操作無法復原，確定進行嗎？"
            case .resetFoodList:
                return "將重置食物清單，\n此操作無法復原，確定進行嗎？"
            case .inactive:
                return ""
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
