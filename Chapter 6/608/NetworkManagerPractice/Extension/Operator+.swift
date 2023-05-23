//
//  Operator+.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/1.
//

import Foundation

func ==<T, Value: Equatable>(keyPath: KeyPath<T, Value>, value: Value) -> (T) -> Bool {
    { $0[keyPath: keyPath] == value }
}
