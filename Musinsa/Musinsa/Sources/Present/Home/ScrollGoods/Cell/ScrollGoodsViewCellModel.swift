//
//  BannerViewCellModel.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

final class ScrollGoodsViewCellModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let goods: Goods
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init(content: Goods) {
        state = State(goods: content)
    }
}
