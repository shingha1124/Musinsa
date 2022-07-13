//
//  HomeSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

struct HomeSection: Decodable {
    let header: Header?
    let footer: Footer?
    let contents: Contents
}
