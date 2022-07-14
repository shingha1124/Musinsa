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
            
            let sectionViewModels = homeModel.data
                .map { SectionViewModel(section: $0) }
            
            let tappedContent = sectionViewModels.flatMap {
                $0.items.map { $0.action.tappedContent }
            }
            
            tappedContent.forEach {
                $0.bind(onNext: { [weak self] content in
                    self?.state.openUrl.accept(content.linkURL)
                })
                .disposeBag(disposeBag)
            }
            
            let tappedSeeAll = sectionViewModels.compactMap {
                $0.header?.action.tappedSeeAll
            }
            
            tappedSeeAll.forEach {
                $0.bind(onNext: { [weak self] header in
                    if let url = header.linkURL {
                        self?.state.openUrl.accept(url)
                    }
                })
                .disposeBag(disposeBag)
            }
            
            let reloadSection = sectionViewModels.enumerated().compactMap { index, model in
                (index, model.reloadSection)
            }
            
            reloadSection.forEach { index, event in
                event.bind(onNext: { [weak self] _ in
                    self?.state.reloadSection.accept(index)
                })
                .disposeBag(disposeBag)
            }
            
            sectionViewModels.forEach {
                state.appendSection.accept($0)
            }
            
            state.reloadData.accept(())
        }
    }
}
