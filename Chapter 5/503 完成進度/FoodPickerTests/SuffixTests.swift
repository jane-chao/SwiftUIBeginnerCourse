//
//  SuffixTests.swift
//  FoodPickerTests
//
//  Created by Jane Chao on 23/02/18.
//

import XCTest
@testable import FoodPicker

final class SuffixTests: XCTestCase {
    var sut: Suffix!
    
    func testJoinNumberAndSuffix() {
        sut = .init(wrappedValue: 100, "")
        XCTAssertEqual(sut.projectedValue, "100", "沒有後綴時不應該有空白鍵")
        
        sut = .init(wrappedValue: 100.1, "大卡")
        XCTAssertEqual(sut.projectedValue, "100.1 大卡")
    }
    
    func testNumberFormatter() {
        sut = .init(wrappedValue: 100, "g")
        XCTAssertEqual(sut.projectedValue, "100 g")
        
        sut = .init(wrappedValue: 100.678, "g")
        XCTAssertEqual(sut.projectedValue, "100.7 g", "應該要在小數點第一位四捨五入")
        
        sut = .init(wrappedValue: -100.678, "g")
        XCTAssertEqual(sut.projectedValue, "-100.7 g")
        
        sut = .init(wrappedValue: 100.6111, "g")
        XCTAssertEqual(sut.projectedValue, "100.6 g")
    }
}
