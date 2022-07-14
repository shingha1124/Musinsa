//
//  ScrollGoodsSectionViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import Foundation

final class ScrollGoodsSectionViewModel: SectionViewModel, ViewModel {
    
    struct Action {
        let loadData = PublishRelay<Void>()
        let tappedCell = PublishRelay<Content>()
        let tappedSeeAll = PublishRelay<Header>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let header: HomeSectionHeaderViewModel?
    }
    
    let action = Action()
    let state: State
    let type: Contents.`Type`
        
    subscript(index: Int) -> SectionCellViewModel {
        cellModels[index]
    }
    
    private var cellModels = [SectionCellViewModel]()
    private let disposeBag = DisposeBag()
    
    init(section: HomeSection) {
        type = section.contents.type
        let header = HomeSectionHeaderViewModel(header: section.header)
        state = State(header: header)
        
        cellModels = section.contents.items
            .map { SectionCellViewModel(content: $0) }
        
        action.loadData
            .bind(onNext: { [weak self] _ in
                let count = section.contents.items.count
                self?.state.itemCount.accept(count)
            })
            .disposeBag(disposeBag)
        
        cellModels.forEach {
            $0.action.tappedContent
                .bind(onNext: { [weak self] content in
                    self?.action.tappedCell.accept(content)
                })
                .disposeBag(disposeBag)
        }
        
        header?.action.tappedSeeAll
            .bind(onNext: { [weak self] header in
                self?.action.tappedSeeAll.accept(header)
            })
            .disposeBag(disposeBag)
    }
}
