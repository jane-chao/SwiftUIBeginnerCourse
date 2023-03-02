//
//  SettingsScreen+Dialog.swift
//  FoodPicker
//
//  Created by Jane Chao on 23/01/18.
//

import Foundation

extension SettingsScreen {
    enum Dialog: String {
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
}

extension SettingsScreen.Dialog {
    func action() {
        switch self {
            case .resetSettings:
                let keys: [UserDefaults.Key] = [.shouldUseDarkMode, .unit, .startTab]
                for key in keys {
                    UserDefaults.standard.removeObject(forKey: key.rawValue)
                }
                
            case .resetFoodList:
                UserDefaults.standard.removeObject(forKey: UserDefaults.Key.foodList.rawValue)
                
            case .inactive:
                return
        }
    }
}

extension SettingsScreen.Dialog: CaseIterable {
    static let allCases: [Self] = [.resetSettings, .resetFoodList]
}

extension SettingsScreen.Dialog: Identifiable {
    var id: Self { self }
}
