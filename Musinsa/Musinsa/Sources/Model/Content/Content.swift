//
//  Content.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

struct Contents: Content {
    let type: `Type`
    let items: [Content]
    
    enum CodingKeys: String, CodingKey {
        case type, items
        case banners
        case goods
        case styles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(`Type`.self, forKey: .type)
        
        switch type {
        case .banner:
            items = try container.decode([Banner].self, forKey: .banners)
        case .style:
            items = try container.decode([Style].self, forKey: .styles)
        default:
            items = try container.decode([Goods].self, forKey: .goods)
        }
    }
}

extension Contents {
    @frozen
    enum `Type`: String, Codable {
        case banner = "BANNER"
        case grid = "GRID"
        case scroll = "SCROLL"
        case style = "STYLE"
        
        var cellType: BaseCollectionViewCell.Type {
            switch self {
            case .banner:
                return BannerViewCell.self
            case .grid:
                return BannerViewCell.self
            case .scroll:
                return BannerViewCell.self
            case .style:
                return BannerViewCell.self
            }
        }
    }
}

protocol Content: Decodable {
}
