//
//  BaseAPI.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

protocol BaseAPI {
    var parameter: [String: Any]? { get }
    var path: String { get }
    var method: String { get }
}

extension BaseAPI {
    var baseURL: URL {
        //swiftlint: disable force_unwrapping
        URL(string: "https://meta.musinsa.com")!
    }
}
