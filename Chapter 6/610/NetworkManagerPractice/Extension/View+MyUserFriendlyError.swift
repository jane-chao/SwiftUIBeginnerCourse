//
//  View+MyUserFriendlyError.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/17.
//

import SwiftUI

private struct MyUserFriendlyError: LocalizedError {
    var errorDescription: String?
    
    init?(errorDescription: String? = nil) {
        guard let errorDescription else { return nil }
        self.errorDescription = errorDescription
    }
}

extension View {
    func alert(errorMessage: Binding<String?>) -> some View {
        alert(isPresented: Binding(
            get: { errorMessage.wrappedValue != nil },
            set: { _ in errorMessage.wrappedValue = nil }
        ), error: MyUserFriendlyError(errorDescription: errorMessage.wrappedValue)) { }
    }
}
