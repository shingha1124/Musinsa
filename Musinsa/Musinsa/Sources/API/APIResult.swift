//
//  APIResult.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

struct ApiResult<T, Error: Swift.Error> {
    private(set) var value: T?
    private(set) var error: Error?
}
