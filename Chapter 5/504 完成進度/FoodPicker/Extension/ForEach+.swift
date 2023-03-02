//
//  ForEach+.swift
//  FoodPicker
//
//  Created by Jane Chao on 23/01/18.
//

import SwiftUI

extension ForEach where Data.Element: Identifiable & View, ID == Content.ID, Content == Data.Element {
    init(_ data: Data) {
        self.init(data) { $0 }
    }
}
