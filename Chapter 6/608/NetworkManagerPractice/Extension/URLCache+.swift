//
//  URLCache+.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import Foundation

extension URLCache {
    static let imageCache: URLCache = {
        URLCache(memoryCapacity: 20 * 1024 * 1024,
                 diskCapacity: 30 * 1024 * 1024,
                 directory: FileManager.default.temporaryDirectory)
    }()
}
