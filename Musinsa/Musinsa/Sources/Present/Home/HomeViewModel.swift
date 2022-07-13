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
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    private let musinsaRepository: MusinsaRepository = MusinsaRepositoryImpl()
    
    init() {
        action.viewDidLoad
            .bind(onNext: { [weak self] _ in
                self?.musinsaRepository.requestHome()
            })
            .disposeBag(disposeBag)
    }
}
