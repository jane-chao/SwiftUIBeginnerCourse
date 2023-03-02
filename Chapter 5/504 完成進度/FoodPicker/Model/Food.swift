//
//  Food.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/10/09.
//

import SwiftUI

struct Food: Equatable, Identifiable {
    var id = UUID()
    var name: String
    var image: String
    @Energy var calorie: Double
    @Weight var carb: Double
    @Weight var fat: Double
    @Weight var protein: Double
}


// MARK: statics
extension Food {
    static var new: Food {
        let preferredWeightUnit = MyWeightUnit.getPreferredUnit()
        let preferredEnergyUnit = MyEnergyUnit.getPreferredUnit()
        
        return Food(name: "", image: "",
             calorie: .init(wrappedValue: .zero, preferredEnergyUnit),
             carb: .init(wrappedValue: .zero, preferredWeightUnit), fat: .init(wrappedValue: .zero, preferredWeightUnit), protein: .init(wrappedValue: .zero, preferredWeightUnit))
    }
    
    private init(id: UUID = UUID(), name: String, image: String, calorie: Double, carb: Double, fat: Double, protein: Double) {
        self.id = id
        self.name = name
        self.image = image
        self._calorie = .init(wrappedValue: calorie, .cal)
        self._carb    = .init(wrappedValue: carb, .gram)
        self._fat     = .init(wrappedValue: fat, .gram)
        self._protein = .init(wrappedValue: protein, .gram)
    }
    
    static let examples = [
        Food(name: "漢堡", image: "🍔", calorie: 294, carb: 14, fat: 24, protein: 17),
        Food(name: "沙拉", image: "🥗", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Food(name: "披薩", image: "🍕", calorie: 266, carb: 33, fat: 10, protein: 11),
        Food(name: "義大利麵", image: "🍝", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Food(name: "雞腿便當", image: "🍗🍱", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Food(name: "刀削麵", image: "🍜", calorie: 256, carb: 56, fat: 1, protein: 8),
        Food(name: "火鍋", image: "🍲", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Food(name: "牛肉麵", image: "🐄🍜", calorie: 219, carb: 33, fat: 5, protein: 9),
        Food(name: "關東煮", image: "🥘", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]
}

extension Food: Codable { }
