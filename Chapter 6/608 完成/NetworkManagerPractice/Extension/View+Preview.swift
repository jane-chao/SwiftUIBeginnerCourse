//
//  View+Preview.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/18.
//

import SwiftUI

extension View {
    func previewEnvironmentObject() -> some View {
        environmentObject(CatAPIManager.preview)
    }
}
