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
        let tappedFooter = PublishRelay<Footer>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let reloadItems = PublishRelay<Range<Int>>()
        let header: HomeSectionHeaderViewModel?
        let footer: HomeSectionFooterViewModel?
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
        let footer = HomeSectionFooterViewModel(footer: section.footer)
        state = State(header: header, footer: footer)
        
        cellModels = section.contents.items
            .map { SectionCellViewModel(content: $0) }
        
        action.loadData
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                let startCount = min(Constants.moreAddCount, self.cellModels.count)
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
        
        footer?.action.tappedFooter
            .bind(onNext: { [weak self] footer in
                self?.action.tappedFooter.accept(footer)
            })
            .disposeBag(disposeBag)
        
        footer?.action.tappedFooter
            .bind(onNext: { [weak self] footer in
                guard let self = self else { return }
                switch footer.type {
                case .more:
                    let currentCount = self.state.itemCount.value ?? 0
                    let stackCount = currentCount + Constants.moreAddCount
                    let viewCount = min(stackCount, self.cellModels.count)
                    self.state.itemCount.accept(viewCount)
                    self.state.reloadItems.accept(currentCount..<viewCount)
                case .refresh:
                    self.cellModels.shuffle()
                    let currentCount = self.state.itemCount.value ?? 0
                    self.state.reloadItems.accept(0..<currentCount)
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
