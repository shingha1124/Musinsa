//
//  HomeSectionFooterViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class HomeSectionFooterViewModel: ViewModel {
    struct Action {
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
//        state = State(footer: footer)
        state = State(footer: Footer(type: .more, title: "새로운 추천", iconURL: URL(string: "https://image.msscdn.net/icons/mobile/clock.png")))
    }
}
