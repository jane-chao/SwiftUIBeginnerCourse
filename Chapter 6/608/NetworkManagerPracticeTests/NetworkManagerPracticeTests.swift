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
    
    func testAddToFavorite() async throws {
        let id = try await sut.addToFavorite(imageID: "")
        XCTAssertEqual(100038507, id)
    }
    
    func testGetFavorite() async throws {
        do {
            let url = (try await sut.getFavorites()).first!.imageURL
            XCTAssertEqual(url, "https://cdn2.thecatapi.com/images/E8dL1Pqpz.jpg")
        } catch {
            XCTFail("❌ Unexpected Error: \(error)")
        }
    }
}
