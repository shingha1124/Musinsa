//
//  HomeSectionFooterViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class HomeSectionFooterViewModel: ViewModel {
    struct Action {
        let tappedFooter = PublishRelay<Footer>()
        let tappedMore = PublishRelay<Void>()
        let tappedRefresh = PublishRelay<Void>()
    }
    
    struct State {
        let footer: Footer
        let isMax = PublishRelay<Bool>()
        let itemCount = PublishRelay<Int>()
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init?(footer: Footer?) {
        guard let footer = footer else {
            return nil
        }
        state = State(footer: footer)
        
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
