//
//  BannerSectionViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import Foundation

final class BannerSectionViewModel: SectionViewModel, ViewModel {
    
    struct Action {
        let reloadSection = PublishRelay<Void>()
        let loadData = PublishRelay<Void>()
        let tappedCell = PublishRelay<Content>()
        let changePage = PublishRelay<Int>()
        let isScrolling = PublishRelay<(Bool, Int)>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let scrollToItem = PublishRelay<Int>()
        let bannerCounting: BannerPageCountingViewModel
    }
    
    let action = Action()
    let state: State
    let type: Contents.`Type` = .banner
        
    subscript(index: Int) -> SectionCellViewModel {
        cellModels[index]
    }
    
    private var cellModels = [SectionCellViewModel]()
    private let disposeBag = DisposeBag()
    private let cellMaxIndex: Int
    private var realPage: Int = 19 {
        didSet {
            if realPage >= cellMaxIndex {
                realPage = 0
            }
        }
    }
    
    init(section: HomeSection) {
        let bannerCountingModel = BannerPageCountingViewModel()
        state = State(bannerCounting: bannerCountingModel)
        cellMaxIndex = section.contents.items.count
        cellModels = section.contents.items
            .map { SectionCellViewModel(content: $0) }
        cellModels.insert(cellModels[cellModels.count - 1], at: 0)
        cellModels.append(cellModels[1])
        
        action.loadData
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.state.itemCount.accept(self.cellModels.count)
            })
            .disposeBag(disposeBag)
        
        action.reloadSection
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.state.scrollToItem.accept(1)
            })
            .disposeBag(disposeBag)
        
        cellModels.forEach {
            $0.action.tappedContent
                .bind(onNext: { [weak self] content in
                    self?.action.tappedCell.accept(content)
                })
                .disposeBag(disposeBag)
        }
        
        action.changePage
            .bind(onNext: { [weak self] page in
                guard let self = self else { return }
                var newPage = page
                let maxCount = self.cellModels.count - 1
                
                if newPage == 0 {
                    newPage = maxCount - 1
                } else if newPage == maxCount {
                    newPage = 1
                }
                
                let realPage = newPage - 1
                
                if self.realPage != realPage {
                    self.realPage = realPage
                    self.state.scrollToItem.accept(newPage)
                    self.state.bannerCounting.state.page.accept((realPage + 1, self.cellMaxIndex))
                }
            })
            .disposeBag(disposeBag)
    }
}
