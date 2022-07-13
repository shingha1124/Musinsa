//
//  BannerViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class BannerSectionViewModel: SectionViewModel {
    let type: Contents.`Type`
    let header: HomeSectionHeaderViewModel?
    let footer: HomeSectionFooterViewModel?
    
    var count: Int {
        cellModels.count
    }
    
    subscript(index: Int) -> BannerViewCellModel {
        cellModels[index]
    }
    
    private var cellModels = [BannerViewCellModel]()
    
    init(section: HomeSection) {
        header = HomeSectionHeaderViewModel(header: section.header)
        footer = HomeSectionFooterViewModel(footer: section.footer)
        type = section.contents.type
        
        cellModels = section.contents.items
            .compactMap { $0 as? Banner }
            .map { BannerViewCellModel(content: $0) }
    }
}
