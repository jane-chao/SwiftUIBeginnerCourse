//
//  SettingsScreen.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/12/28.
//

import SwiftUI

struct SettingsScreen: View {
    @AppStorage(.shouldUseDarkMode) private var shouldUseDarkMode: Bool = false
    @AppStorage(.unit) private var unit: Unit = .gram
    @AppStorage(.startTab) private var startTab: HomeScreen.Tab = .picker
    @State private var confirmationDialog: Dialog = .inactive
    
    private var shouldShowDialog: Binding<Bool> {
        Binding(
            get: { confirmationDialog != .inactive },
            set: { _ in confirmationDialog = .inactive }
        )
    }
    
    
    var body: some View {
        Form {
            Section("基本設定") {
                Toggle(isOn: $shouldUseDarkMode) {
                    Label("深色模式", systemImage: .moon)
                }
                
                Picker(selection: $unit) {
                    ForEach(Unit.allCases) { $0 }
                } label: {
                    Label("單位", systemImage: .unitSign)
                }
                
                Picker(selection: $startTab) {
                    Text("隨機食物").tag(HomeScreen.Tab.picker)
                    Text("食物清單").tag(HomeScreen.Tab.list)
                } label: {
                    Label("啟動畫面", systemImage: .house)
                }
            }
            
            Section("危險區域") {
                ForEach(Dialog.allCases) { dialog in
                    Button(dialog.rawValue) { confirmationDialog = dialog }
                        .tint(Color(.label))
                }
            }
            .confirmationDialog(confirmationDialog.rawValue,
                                isPresented: shouldShowDialog,
                                titleVisibility: .visible) {
                Button("確定", role: .destructive, action: confirmationDialog.action)
                Button("取消", role: .cancel) { }
            } message: {
                Text(confirmationDialog.message)
            }
            
        }
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
    
    func action() {
        switch self {
            case .resetSettings:
                let keys: [UserDefaults.Key] = [.shouldUseDarkMode, .unit, .startTab]
                for key in keys {
                    UserDefaults.standard.removeObject(forKey: key.rawValue)
                }
            case .resetFoodList:
                fatalError() // TODO: 儲存食物清單
            case .inactive:
                return
        }
    }
}

extension Dialog: CaseIterable {
    static let allCases: [Dialog] = [.resetSettings, .resetFoodList]
}

extension Dialog: Identifiable {
    var id: Self { self }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
