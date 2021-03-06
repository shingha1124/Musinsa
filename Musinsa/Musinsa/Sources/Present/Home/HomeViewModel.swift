//
//  HomeViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class HomeViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let appendSections = PublishRelay<[SectionViewModel]>()
        let reloadData = PublishRelay<Void>()
        let reloadItems = PublishRelay<[IndexPath]>()
        let scrollToItem = PublishRelay<(IndexPath, Bool)>()
        let insertItems = PublishRelay<[IndexPath]>()
        let openUrl = PublishRelay<URL>()
    }
    
    let action = Action()
    let state = State()
    private let disposeBag = DisposeBag()
    
    private let musinsaRepository: MusinsaRepository = MusinsaRepositoryImpl()
        
    init() {
        action.viewDidLoad
            .bind(onNext: requestHome)
            .disposeBag(disposeBag)
    }
    
    private func requestHome() {
        Task {
            let recive = try await self.musinsaRepository.requestHome()
            if let error = recive.error {
                return
            }
            
            guard let homeModel = recive.value else {
                return
            }
            
            let sectionViewModels = homeModel.data.enumerated()
                .compactMap { index, section -> SectionViewModel? in
                    switch section.contents.type {
                    case .banner:
                        let model = BannerSectionViewModel(section: section)
                        self.bannerSectionBind(model, section: index)
                        return model
                    case .grid:
                        let model = GridGoodsSectionViewModel(section: section)
                        self.gridSectionBind(model, section: index)
                        return model
                    case .scroll:
                        let model = ScrollGoodsSectionViewModel(section: section)
                        self.scrollSectionBind(model, section: index)
                        return model
                    case .style:
                        let model = StyleSectionViewModel(section: section)
                        self.styleSectionBind(model, section: index)
                        return model
                    }
                }
            state.appendSections.accept(sectionViewModels)
        }
    }
    
    private func bannerSectionBind(_ model: BannerSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
        bindScrollToItem(model.state.scrollToItem, section: section)
    }
    
    private func styleSectionBind(_ model: StyleSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
        bindTappedSeeAll(model.action.tappedSeeAll)
        bindInsertItems(model.state.insertItems, section: section)
        bindReloadItems(model.state.reloadItems, section: section)
        bindScrollToItem(model.state.scrollToItem, section: section)
    }
    
    private func gridSectionBind(_ model: GridGoodsSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
        bindTappedSeeAll(model.action.tappedSeeAll)
        bindInsertItems(model.state.insertItems, section: section)
        bindReloadItems(model.state.reloadItems, section: section)
        bindScrollToItem(model.state.scrollToItem, section: section)
    }
    
    private func scrollSectionBind(_ model: ScrollGoodsSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
        bindTappedSeeAll(model.action.tappedSeeAll)
    }
    
    private func bindScrollToItem(_ relay: PublishRelay<(Int, Bool)>, section: Int) {
        relay
            .bind(onNext: { [weak self] item, animate in
                let indexPath = IndexPath(item: item, section: section)
                self?.state.scrollToItem.accept((indexPath, animate))
            })
            .disposeBag(disposeBag)
    }
    
    private func bindInsertItems(_ relay: PublishRelay<Range<Int>>, section: Int) {
        relay.bind(onNext: { [weak self] range in
            let indexPaths = range.map { IndexPath(item: $0, section: section) }
            self?.state.insertItems.accept(indexPaths)
        })
        .disposeBag(disposeBag)
    }
    
    private func bindReloadItems(_ relay: PublishRelay<[Int]>, section: Int) {
        relay.bind(onNext: { [weak self] items in
            let indexPaths = items.map { IndexPath(item: $0, section: section) }
            self?.state.reloadItems.accept(indexPaths)
        })
        .disposeBag(disposeBag)
    }
    
    private func bindTappedCell(_ relay: PublishRelay<Content>) {
        relay.bind(onNext: { [weak self] content in
            self?.state.openUrl.accept(content.linkURL)
        })
        .disposeBag(disposeBag)
    }
    
    private func bindTappedSeeAll(_ relay: PublishRelay<Header>) {
        relay.bind(onNext: { [weak self] header in
            guard let url = header.linkURL else { return }
            self?.state.openUrl.accept(url)
        })
        .disposeBag(disposeBag)
    }
}
