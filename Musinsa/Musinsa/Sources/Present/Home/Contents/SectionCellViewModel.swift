//
//  SectionCellViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import Foundation

final class SectionCellViewModel: ViewModel {
    struct Action {
        let tappedContent = PublishRelay<Content>()
    }
    
    struct State {
        let content: Content
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init(content: Content) {
        state = State(content: content)
    }
}
