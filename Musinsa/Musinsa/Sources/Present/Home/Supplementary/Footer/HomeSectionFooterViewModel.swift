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
    }
    
    struct State {
        let footer: Footer
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init?(footer: Footer?) {
        guard let footer = footer else {
            return nil
        }
//        state = State(footer: Footer(type: .more, title: "테스트타이틀", iconURL: nil))
        state = State(footer: footer)
    }
}
