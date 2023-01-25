//
//  Unit.swift
//  FoodPicker
//
//  Created by Jane Chao on 23/01/17.
//

import SwiftUI

enum Unit: String {
    case gram = "g", pound = "lb"
}

extension Unit: View {
    var body: some View {
        Text(rawValue)
    }
}

extension Unit: Identifiable {
    var id: Self { self }
}

extension Unit: CaseIterable { }
