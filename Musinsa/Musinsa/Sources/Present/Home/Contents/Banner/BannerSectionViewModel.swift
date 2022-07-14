//
//  BannerSectionViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import Foundation

final class BannerSectionViewModel: SectionViewModel, ViewModel {
    
    struct Action {
        let loadData = PublishRelay<Void>()
        let tappedCell = PublishRelay<Content>()
        let changePage = PublishRelay<Int>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
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
    
    init(section: HomeSection) {
        let bannerCountingModel = BannerPageCountingViewModel()
        state = State(bannerCounting: bannerCountingModel)
        
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
        
        action.changePage
            .bind(onNext: {
                bannerCountingModel.state.page.accept(($0, section.contents.items.count))
            })
            .disposeBag(disposeBag)
    }
}
