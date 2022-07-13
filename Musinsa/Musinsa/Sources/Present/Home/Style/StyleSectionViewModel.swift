//
//  BannerViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class StyleSectionViewModel: SectionViewModel {
    let type: Contents.`Type`
    let header: Header?
    let footer: Footer?
    
    var count: Int {
        cellModels.count
    }
    
    subscript(index: Int) -> StyleViewCellModel {
        cellModels[index]
    }
    
    private var cellModels = [StyleViewCellModel]()
    
    init(section: HomeSection) {
        header = section.header
        footer = section.footer
        type = section.contents.type
        
        cellModels = section.contents.items
            .compactMap { $0 as? Style }
            .map { StyleViewCellModel(content: $0) }
    }
}
