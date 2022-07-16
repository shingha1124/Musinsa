//
//  StyleSectionViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import Foundation

final class StyleSectionViewModel: SectionViewModel, ViewModel {
    
    enum Constants {
        static let startRowCount = 4
        static let columnCount = 2
    }
    
    struct Action {
        let loadData = PublishRelay<Void>()
        let tappedCell = PublishRelay<Content>()
        let tappedSeeAll = PublishRelay<Header>()
        let tappedFooter = PublishRelay<Footer>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let insertItems = PublishRelay<Range<Int>>()
        let reloadItems = PublishRelay<[Int]>()
        let scrollToItem = PublishRelay<(Int, Bool)>()
        let header: HomeSectionHeaderViewModel?
        let footer: HomeSectionFooterViewModel?
    }
    
    let action = Action()
    let state: State
    let type: Contents.`Type` = .style
    
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
                let startCount = min(Constants.startRowCount, self.cellModels.count)
                self.state.itemCount.accept(startCount)
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
                let stackCount = currentCount + Constants.columnCount
                let viewCount = min(stackCount, self.cellModels.count)
                
                self.state.itemCount.accept(viewCount)
                self.state.insertItems.accept(currentCount..<viewCount)
                self.state.scrollToItem.accept((viewCount - 1, false))
                self.state.footer?.state.isMax.accept(viewCount >= self.cellModels.count)
            })
            .disposeBag(disposeBag)
        
        footer?.action.tappedRefresh
            .bind(onNext: { [weak self] _ in
                guard let itemCount = self?.state.itemCount.value else {
                    return
                }
                self?.cellModels.shuffle()
                let items = Array(0..<itemCount)
                self?.state.reloadItems.accept(items)
            })
            .disposeBag(disposeBag)
    }
}
