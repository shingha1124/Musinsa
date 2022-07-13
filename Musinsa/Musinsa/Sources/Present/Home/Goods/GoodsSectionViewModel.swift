//
//  BannerViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class GoodsSectionViewModel: SectionViewModel {
    let type: Contents.`Type`
    let header: Header?
    let footer: Footer?
    
    var count: Int {
        cellModels.count
    }
    
    subscript(index: Int) -> GoodsViewCellModel {
        cellModels[index]
    }
    
    private var cellModels = [GoodsViewCellModel]()
    
    init(section: HomeSection) {
        header = section.header
        footer = section.footer
        type = section.contents.type
        
        cellModels = section.contents.items
            .compactMap { $0 as? Goods }
            .map { GoodsViewCellModel(content: $0) }
    }
}
