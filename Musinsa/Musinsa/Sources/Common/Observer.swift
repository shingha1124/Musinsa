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
    private var dispatch: DispatchQueue?

    func bind(onNext: @escaping BinderElement) -> PublishRelay<T> {
        binder.append(onNext)
        return self
    }

    func mainThread() -> PublishRelay<T> {
        dispatch = DispatchQueue.main
        return self
    }
    
    func accept(_ value: T) {
        if let dispatch = dispatch {
            dispatch.async {
                self.binder.forEach { $0(value) }
            }
            return
        }
        binder.forEach { $0(value) }
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
