//
//  Observer.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

protocol Observer {
    func disposeBag(_ bag: DisposeBag)
    func removeAll()
}

class PublishRelay<T>: Observer {
    typealias BinderElement = (T) -> Void
    
    private var binder: [BinderElement] = []
    private var dispatch: DispatchQueue?
    private var element: T?
    
    var value: T? {
        element
    }

    func bind(onNext: @escaping BinderElement) -> PublishRelay<T> {
        binder.append(onNext)
        return self
    }

    func mainQueue() -> PublishRelay<T> {
        dispatch = DispatchQueue.main
        return self
    }
    
    func accept(_ value: T) {
        self.element = value
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
    
    func removeAll() {
        binder.removeAll()
    }
}

class DisposeBag {
    private var bag = [Observer]()
    
    func append(_ observer: Observer) {
        bag.append(observer)
    }
    
    deinit {
        bag.forEach {
            $0.removeAll()
        }
        bag.removeAll()
    }
}
