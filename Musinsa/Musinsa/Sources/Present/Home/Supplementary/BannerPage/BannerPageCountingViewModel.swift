//
//  BannerPageCountingViewModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import Foundation

final class BannerPageCountingViewModel: ViewModel {
    
    struct Action {
    }
    
    struct State {
        let page = PublishRelay<(current: Int, max: Int)>()
    }
    
    let action = Action()
    let state = State()
}
