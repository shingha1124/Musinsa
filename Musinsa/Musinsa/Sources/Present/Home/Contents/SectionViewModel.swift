//
//  SectionViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class SectionViewModel {
    let type: Contents.`Type`
    let header: HomeSectionHeaderViewModel?
    let footer: HomeSectionFooterViewModel?
    let addViewCount = PublishRelay<Void>()
    let reloadSection = PublishRelay<Void>()
    
    var count: Int {
        cellModels.count
    }
    
    var items: [SectionCellViewModel] {
        cellModels
    }
    
    subscript(index: Int) -> SectionCellViewModel {
        cellModels[index]
    }
    
    private var cellModels = [SectionCellViewModel]()
    private let disposeBag = DisposeBag()
    
    init(section: HomeSection) {
        header = HomeSectionHeaderViewModel(header: section.header)
        footer = HomeSectionFooterViewModel(footer: section.footer)
        type = section.contents.type
        
        cellModels = section.contents.items
            .map { SectionCellViewModel(content: $0) }
        
        footer?.action.tappedFooter
            .bind(onNext: { [weak self] footer in
                switch footer.type {
                case .more:
                    self?.addViewCount.accept(())
                    self?.reloadSection.accept(())
                case .refresh:
                    self?.randomIndex()
                    self?.reloadSection.accept(())
                }
            })
            .disposeBag(disposeBag)
    }
    
    private func randomIndex() {
        (0..<cellModels.count).forEach { index in
            let randomIndex = Int.random(in: index..<cellModels.count)
            let cell = cellModels.remove(at: randomIndex)
            cellModels.insert(cell, at: 0)
        }
    }
}
