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
        let appendSection = PublishRelay<SectionViewModel>()
        let reloadData = PublishRelay<Void>()
        let reloadSection = PublishRelay<Int>()
        let openUrl = PublishRelay<URL>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
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
            
            sectionViewModels.forEach {
                state.appendSection.accept($0)
            }
            
            state.reloadData.accept(())
        }
    }
    
    private func bannerSectionBind(_ model: BannerSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
    }
    
    private func styleSectionBind(_ model: StyleSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
        bindTappedSeeAll(model.action.tappedSeeAll)
        bindReloadSection(model.state.reloadSection, section: section)
    }
    
    private func gridSectionBind(_ model: GridGoodsSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
        bindTappedSeeAll(model.action.tappedSeeAll)
        bindReloadSection(model.state.reloadSection, section: section)
    }
    
    private func scrollSectionBind(_ model: ScrollGoodsSectionViewModel, section: Int) {
        bindTappedCell(model.action.tappedCell)
        bindTappedSeeAll(model.action.tappedSeeAll)
    }
    
    private func bindReloadSection(_ relay: PublishRelay<Void>, section: Int) {
        relay.bind(onNext: { [weak self] _ in
            self?.state.reloadSection.accept(section)
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
