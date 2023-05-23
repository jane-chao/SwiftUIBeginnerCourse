//
//  NetworkManagerPracticeTests.swift
//  NetworkManagerPracticeTests
//
//  Created by Jane Chao on 2023/4/16.
//

import XCTest
@testable import NetworkManagerPractice

final class NetworkManagerPracticeTests: XCTestCase {
    let sut = CatAPIManager.stub
    
    func testGetImages() async throws {
        let images = try await sut.getImages()
        XCTAssertEqual(images.count, 10)
    }
}
