//
//  HomeModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

struct HomeModel: Decodable {
    let data: [HomeSection]
}

struct HomeSection: Decodable {
    let header: Header?
    let footer: Footer?
    let contents: Contents
    
//    enum CodingKeys: String, CodingKey {
//        case header, footer, contents
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        print(container.allKeys)
//        print("--------------222222222")
//        header = try? container.decode(Header.self, forKey: .header)
//        footer = try? container.decode(Footer.self, forKey: .footer)
//        contents = try container.decode(Contents.self, forKey: .contents)
//    }
}

protocol Contentable: Decodable {
}

struct Banner: Contentable {
}

struct Goods: Contentable {
}

struct Style: Contentable {
}

struct Contents: Contentable {
    let type: `Type`
    let items: [Contentable]
    
    enum CodingKeys: String, CodingKey {
        case type, items
        case banners
        case goods
        case styles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(container.allKeys)
        print("--------------33333333")
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
    }
}

struct Header: Decodable {
    let title: String
    let iconURL: URL?
    let linkURL: URL?
}

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
