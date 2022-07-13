//
//  Header.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

struct Header: Decodable {
    let title: String
    let iconURL: URL?
    let linkURL: URL?
}
