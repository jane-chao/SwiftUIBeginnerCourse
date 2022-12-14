//
//  Food.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/10/09.
//

import Foundation

struct Food: Equatable, Identifiable {
    let id = UUID()
    var name: String
    var image: String
    @Suffix("ๅคงๅก") var calorie: Double = .zero
    @Suffix("g") var carb: Double      = .zero
    @Suffix("g") var fat: Double       = .zero
    @Suffix("g") var protein: Double   = .zero
}


// MARK: statics
extension Food {
    static var new: Food { Food(name: "", image: "") }
    
    static let examples = [
        Food(name: "ๆผขๅ ก", image: "๐", calorie: 294, carb: 14, fat: 24, protein: 17),
        Food(name: "ๆฒๆ", image: "๐ฅ", calorie: 89, carb: 20, fat: 0, protein: 1.8),
        Food(name: "ๆซ่ฉ", image: "๐", calorie: 266, carb: 33, fat: 10, protein: 11),
        Food(name: "็พฉๅคงๅฉ้บต", image: "๐", calorie: 339, carb: 74, fat: 1.1, protein: 12),
        Food(name: "้่ฟไพฟ็ถ", image: "๐๐ฑ", calorie: 191, carb: 19, fat: 8.1, protein: 11.7),
        Food(name: "ๅๅ้บต", image: "๐", calorie: 256, carb: 56, fat: 1, protein: 8),
        Food(name: "็ซ้", image: "๐ฒ", calorie: 233, carb: 26.5, fat: 17, protein: 22),
        Food(name: "็่้บต", image: "๐๐", calorie: 219, carb: 33, fat: 5, protein: 9),
        Food(name: "้ๆฑ็ฎ", image: "๐ฅ", calorie: 80, carb: 4, fat: 4, protein: 6),
    ]
}
