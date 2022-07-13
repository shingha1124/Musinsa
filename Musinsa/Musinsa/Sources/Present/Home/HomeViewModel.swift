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
            
            recive.value?.data
                .map { section -> SectionViewModel in
                    switch section.contents.type {
                    case .banner:
                        return makeBannerViewModel(section: section)
                    case .grid:
                        return makeGridGoodsViewModel(section: section)
                    case .scroll:
                        return makeScrollGoodsViewModel(section: section)
                    case .style:
                        return makeStyleViewModel(section: section)
                    }
                }.forEach {
                    state.appendSection.accept($0)
                }
            
            state.reloadData.accept(())
        }
    }
    
    private func makeBannerViewModel(section: HomeSection) -> BannerSectionViewModel {
        let viewModel = BannerSectionViewModel(section: section)
        return viewModel
    }
    
    private func makeStyleViewModel(section: HomeSection) -> StyleSectionViewModel {
        let viewModel = StyleSectionViewModel(section: section)
        return viewModel
    }
    
    private func makeGridGoodsViewModel(section: HomeSection) -> GridGoodsSectionViewModel {
        let viewModel = GridGoodsSectionViewModel(section: section)
        return viewModel
    }
    
    private func makeScrollGoodsViewModel(section: HomeSection) -> ScrollGoodsSectionViewModel {
        let viewModel = ScrollGoodsSectionViewModel(section: section)
        return viewModel
    }
}
