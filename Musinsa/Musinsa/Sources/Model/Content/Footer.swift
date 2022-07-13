//
//  Footer.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

struct Footer: Decodable {
    let type: `Type`
    let title: String
    let iconURL: URL?
}

extension Footer {
    enum `Type`: String, Codable {
        case more = "MORE"
        case refresh = "REFRESH"
    }
}
