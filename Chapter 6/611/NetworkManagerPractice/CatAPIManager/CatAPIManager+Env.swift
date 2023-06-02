//
//  CatAPIManager+Env.swift
//  NetworkManagerPractice
//
//  Created by Jane Chao on 2023/4/16.
//

import SwiftUI

struct CatAPIManagerKey: EnvironmentKey {
    static var defaultValue: CatAPIManager = .shared
}

extension EnvironmentValues {
    var apiManager: CatAPIManager {
        get { self[CatAPIManagerKey.self] }
        set { self[CatAPIManagerKey.self] = newValue }
    }
}
