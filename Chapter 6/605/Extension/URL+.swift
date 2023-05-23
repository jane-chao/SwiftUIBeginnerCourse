//
//  URL+.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: value.description)!
    }
}
