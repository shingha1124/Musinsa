//
//  GridGoodsSectionViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import Foundation

final class GridGoodsSectionViewModel: SectionViewModel, ViewModel {
    
    enum Constants {
        static let moreAddCount = 6
    }
    
    struct Action {
        let loadData = PublishRelay<Void>()
        let tappedCell = PublishRelay<Content>()
        let tappedSeeAll = PublishRelay<Header>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let insertItems = PublishRelay<Range<Int>>()
        let reloadSection = PublishRelay<Void>()
        let scrollToItem = PublishRelay<(Int, Bool)>()
        let header: HomeSectionHeaderViewModel?
        let footer: HomeSectionFooterViewModel?
    }
    
    let action = Action()
    let state: State
    let type: Contents.`Type` = .grid
    
    subscript(index: Int) -> SectionCellViewModel {
        cellModels[index]
    }
    
    private var cellModels = [SectionCellViewModel]()
    private let disposeBag = DisposeBag()
    
    init(section: HomeSection) {
        let header = HomeSectionHeaderViewModel(header: section.header)
        let footer = HomeSectionFooterViewModel(footer: section.footer)
        state = State(header: header, footer: footer)
        
        cellModels = section.contents.items
            .map { SectionCellViewModel(content: $0) }
        
        action.loadData
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                let itemCount = min(Constants.moreAddCount, self.cellModels.count)
                self.state.itemCount.accept(itemCount)
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
        
        footer?.action.tappedMore
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                let currentCount = self.state.itemCount.value ?? 0
                let stackCount = currentCount + Constants.moreAddCount
                let viewCount = min(stackCount, self.cellModels.count)
                
                self.state.itemCount.accept(viewCount)
                self.state.insertItems.accept(currentCount..<viewCount)
                self.state.scrollToItem.accept((viewCount - 1, false))
                self.state.footer?.state.isMax.accept(viewCount >= self.cellModels.count)
            })
            .disposeBag(disposeBag)
        
        footer?.action.tappedRefresh
            .bind(onNext: {
                self.cellModels.shuffle()
                self.state.reloadSection.accept(())
            })
            .disposeBag(disposeBag)
    }
}
