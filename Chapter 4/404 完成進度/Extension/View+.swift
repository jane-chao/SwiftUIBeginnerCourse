//
//  View+.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/12/12.
//

import SwiftUI

extension View {
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        buttonStyle(.borderedProminent)
        .buttonBorderShape(shape)
        .controlSize(.large)
    }
    
    func roundedRectBackground(radius: CGFloat = 8,
                               fill: some ShapeStyle = .bg) -> some View {
        background(RoundedRectangle(cornerRadius: radius).fill(fill))
    }
    
    func sheet(item: Binding<(some View & Identifiable)?>) -> some View {
        sheet(item: item) { $0 }
    }
    
    /// - Tag: push
    func push(to alignment: TextAlignment) -> some View {
        switch alignment {
            case .leading:
                return frame(maxWidth: .infinity, alignment: .leading)
            case .center:
                return frame(maxWidth: .infinity, alignment: .center)
            case .trailing:
                return frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    /// Shortcut: [push(to: .center)](x-source-tag://push)
    func maxWidth() -> some View {
        push(to: .center)
    }
    
    func readGeometry<Key: PreferenceKey, Value>(_ keyPath: KeyPath<GeometryProxy, Value>, key: Key.Type) -> some View where Key.Value == Value {
        overlay {
            GeometryReader { proxy in
                Color.clear.preference(key: key,
                                       value: proxy[keyPath: keyPath])
            }
        }
    }
}

