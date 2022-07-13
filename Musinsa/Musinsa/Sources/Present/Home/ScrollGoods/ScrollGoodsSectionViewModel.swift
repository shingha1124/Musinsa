//
//  BannerViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class ScrollGoodsSectionViewModel: SectionViewModel {
    let type: Contents.`Type`
    let header: Header?
    let footer: Footer?
    
    var count: Int {
        cellModels.count
    }
    
    subscript(index: Int) -> ScrollGoodsViewCellModel {
        cellModels[index]
    }
    
    private var cellModels = [ScrollGoodsViewCellModel]()
    
    init(section: HomeSection) {
        header = section.header
        footer = section.footer
        type = section.contents.type
        
        cellModels = section.contents.items
            .compactMap { $0 as? Goods }
            .map { ScrollGoodsViewCellModel(content: $0) }
    }
}
