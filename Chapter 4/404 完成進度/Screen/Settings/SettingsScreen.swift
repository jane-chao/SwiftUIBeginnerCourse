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
                Toggle(isOn: $shouldUseDarkMode) { Label("深色模式", systemImage: .moon) }
                
                Picker(selection: $unit) {
                    ForEach(Unit.allCases)
                } label: { Label("單位", systemImage: .unitSign) }
                
                Picker(selection: $startTab) {
                    Text("隨機食物").tag(HomeScreen.Tab.picker)
                    Text("食物清單").tag(HomeScreen.Tab.list)
                } label: { Label("啟動畫面", systemImage: .house) }
            }
            
            Section("危險區域") {
                ForEach(Dialog.allCases) { dialog in
                    Button(dialog.rawValue) { confirmationDialog = dialog }
                        .tint(Color(.label))
                }
            }
            .confirmationDialog(confirmationDialog.rawValue,
                                isPresented: shouldShowDialog,
                                titleVisibility: .visible,
                                actions: buildConfirmationDialogButtons) {
                Text(confirmationDialog.message)
            }
        }
    }
    
    private func buildConfirmationDialogButtons() -> some View {
        Group {
            Button("確定", role: .destructive, action: confirmationDialog.action)
            Button("取消", role: .cancel) { }
        }
    }
}


struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
