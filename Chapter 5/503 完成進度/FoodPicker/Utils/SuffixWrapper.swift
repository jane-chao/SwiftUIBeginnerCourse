//
//  SuffixWrapper.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/10/19.
//

@propertyWrapper struct Suffix: Equatable {
    var wrappedValue: Double
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String {
        let suffix = suffix.isEmpty ? "" : " \(suffix)"
        return wrappedValue.formatted(.number.precision(.fractionLength(0...1))) + suffix
    }
}

extension Suffix: Codable { }
