//
//  URLSession+.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import Foundation

extension URLSession {
    static var imageSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .imageCache
        return URLSession(configuration: config)
    }()
}
