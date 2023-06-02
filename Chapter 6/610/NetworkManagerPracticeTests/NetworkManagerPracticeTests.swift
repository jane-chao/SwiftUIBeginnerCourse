//
//  NetworkManagerPracticeTests.swift
//  NetworkManagerPracticeTests
//
//  Created by Jane Chao on 2023/4/16.
//

import XCTest
@testable import NetworkManagerPractice

@MainActor
final class NetworkManagerPracticeTests: XCTestCase {
    var sut: CatAPIManager!
    
    override func setUp() {
        sut = .stub
    }
    
    func testGetImages() async throws {
        let images = try await sut.getImages()
        XCTAssertEqual(images.count, 10)
    }
    
    func testAddToFavorite() async throws {
        try await sut.addToFavorite(cat: [CatImageViewModel].stub.first!)
        let id = sut.favorites.first!.id
        XCTAssertEqual(100038507, id)
    }
    
    func testGetFavorite() async throws {
        do {
            try await sut.getFavorites()
            XCTAssertEqual(13, sut.favorites.count)
        } catch {
            XCTFail("❌ Unexpected Error: \(error)")
        }
    }
}

extension CatAPIManager {
    static var stub: CatAPIManager { .init(getData: { $0.stub }) }
}
