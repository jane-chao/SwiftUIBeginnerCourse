//
//  Decoding+.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import Foundation

struct DecodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}


extension DecodingKey: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        stringValue = stringLiteral
    }
}

extension Decoder {
    func container() throws -> KeyedDecodingContainer<DecodingKey> {
        try self.container(keyedBy: DecodingKey.self)
    }
}

extension KeyedDecodingContainer {
    subscript<Value: Decodable>(_ key: Key) -> Value {
        get throws {
            try self.decode(Value.self, forKey: key)
        }
    }
    
    func nestedContainer(key: Key) throws -> KeyedDecodingContainer<DecodingKey> {
        try self.nestedContainer(keyedBy: DecodingKey.self, forKey: key)
    }
}
