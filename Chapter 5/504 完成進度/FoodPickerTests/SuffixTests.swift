//
//  SuffixTests.swift
//  FoodPickerTests
//
//  Created by Jane Chao on 23/02/18.
//

import XCTest
@testable import FoodPicker
import SwiftUI

private let store = UserDefaults(suiteName: #file)!

final class SuffixTests: XCTestCase {
    var sut: Suffix<MyWeightUnit> = .init(wrappedValue: .zero, .defaultUnit, store: store)
    @AppStorage(.preferredWieghtUnit, store: store) var preferredUnit: MyWeightUnit
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removePersistentDomain(forName: #file)
    }
    
    
    func testJoinNumberAndSuffix() {
        sut.wrappedValue = 100.1
        sut.unit = .gram
        XCTAssertEqual(sut.description, "100.1 grams")
    }
    
    func testNumberFormatter_preferredPounds() {
        preferredUnit = .pound
        
        sut.wrappedValue = 100
        sut.unit = .gram
        XCTAssertEqual(sut.description, "0.2 pounds")
        
        sut.wrappedValue = -300
        sut.unit = .gram
        XCTAssertEqual(sut.description, "-0.7 pounds")
        
        sut.wrappedValue = 453.592
        sut.unit = .gram
        XCTAssertEqual(sut.description, "1 pounds")
    }
    
    
    func testNumberFormatter_preferredGrams() {
        sut.wrappedValue = 100
        sut.unit = .gram
        XCTAssertEqual(sut.description, "100 grams")
        
        sut.wrappedValue = 100.678
        sut.unit = .gram
        XCTAssertEqual(sut.description, "100.7 grams", "應該要在小數點第一位四捨五入")
        
        sut.wrappedValue = -100.678
        sut.unit = .gram
        XCTAssertEqual(sut.description, "-100.7 grams")
        
        sut.wrappedValue = 100.6111
        sut.unit = .gram
        XCTAssertEqual(sut.description, "100.6 grams")
    }
}
