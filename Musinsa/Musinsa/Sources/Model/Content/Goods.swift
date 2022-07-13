//
//  Goods.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

struct Goods: Content {
    let linkURL: URL
    let thumbnailURL: URL
    let brandName: String
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
}
