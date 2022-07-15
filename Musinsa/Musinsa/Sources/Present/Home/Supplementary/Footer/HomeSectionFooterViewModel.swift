//
//  HomeSectionFooterViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class HomeSectionFooterViewModel: ViewModel {
    struct Action {
        let loadData = PublishRelay<Void>()
        let tappedFooter = PublishRelay<Footer>()
        let tappedMore = PublishRelay<Void>()
        let tappedRefresh = PublishRelay<Void>()
    }
    
    struct State {
        let footer: Footer
        let isMax = PublishRelay<Bool>()
    }
    
    let action = Action()
    let state: State
    private let disposeBag = DisposeBag()
    
    init?(footer: Footer?) {
        guard let footer = footer else { return nil }
        state = State(footer: footer)
        
        action.loadData
            .bind(onNext: { [weak self] _ in
                let isMax = self?.state.isMax.value ?? false
                self?.state.isMax.accept(isMax)
            })
            .disposeBag(disposeBag)
        
        action.tappedFooter
            .bind(onNext: { [weak self] footer in
                switch footer.type {
                case .more:
                    self?.action.tappedMore.accept(())
                case .refresh:
                    self?.action.tappedRefresh.accept(())
                }
            })
            .disposeBag(disposeBag)
    }
}
