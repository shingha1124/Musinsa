//
//  Observer.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

protocol Observer {
    func disposeBag(_ bag: DisposeBag)
}

class PublishRelay<T>: Observer {
    typealias BinderElement = (T) -> Void
    
    private var binder: [BinderElement] = []

    func bind(onNext: @escaping BinderElement) -> Observer {
        binder.append(onNext)
        return self
    }

    func accept(_ value: T) {
        binder.forEach {
            $0(value)
        }
    }
    
    func disposeBag(_ bag: DisposeBag) {
        bag.append(self)
    }
}

class DisposeBag {
    private var bag = [Observer]()
    
    func append(_ observer: Observer) {
        bag.append(observer)
    }
    
    deinit {
        bag = []
    }
}
