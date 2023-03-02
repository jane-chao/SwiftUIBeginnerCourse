//
//  Unit.swift
//  FoodPicker
//
//  Created by Jane Chao on 23/01/17.
//

import Foundation

enum MyEnergyUnit: String, MyUnitProtocol {
    case cal = "大卡"
    
    var dimension: UnitEnergy {
        switch self {
            case .cal: return .calories
        }
    }
    
    static var userDefaultsKey: UserDefaults.Key = .preferredEnergyUnit
    
    static var defaultUnit: MyEnergyUnit = .cal
}

enum MyWeightUnit: String, MyUnitProtocol {
    case gram = "g", pound = "lb", ounce
    
    var dimension: UnitMass {
        switch self {
            case .gram:
                return .grams
            case .pound:
                return .pounds
            case .ounce:
                return .ounces
        }
    }
    
    static var userDefaultsKey: UserDefaults.Key = .preferredWieghtUnit
    
    static var defaultUnit: MyWeightUnit = .gram
    
}
