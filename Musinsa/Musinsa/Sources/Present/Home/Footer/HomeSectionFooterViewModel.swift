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
        state = State(footer: footer)
    }
}
