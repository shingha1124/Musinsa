//
//  HomeSectionHeaderViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class HomeSectionHeaderViewModel: ViewModel {
    struct Action {
        let tappedSeeAll = PublishRelay<Header>()
    }
    
    struct State {
        let header: Header
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init?(header: Header?) {
        guard let header = header else { return nil }
        state = State(header: header)
    }
}
