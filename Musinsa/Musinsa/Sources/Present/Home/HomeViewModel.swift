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
//        let presentErrorPopup = PublishRelay<String>()
        let appendSection = PublishRelay<SectionViewModel>()
//        let updateSection = PublishRelay<(Int, HomeCollectionSectionModel)>()
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
//                self.state.presentErrorPopup.accept(error.localizedDescription)
                return
            }
            
            let sectionModels = recive.value?.data
                .map { section -> SectionViewModel in
                    switch section.contents.type {
                    case .banner:
                        return makeBannerViewModel(section: section)
                    case .grid:
                        return makeGoodsViewModel(section: section)
                    case .scroll:
                        return makeGoodsViewModel(section: section)
                    case .style:
                        return makeStyleViewModel(section: section)
                    }
                }
            
            sectionModels?.forEach {
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
    
    private func makeGoodsViewModel(section: HomeSection) -> GoodsSectionViewModel {
        let viewModel = GoodsSectionViewModel(section: section)
        return viewModel
    }
}
