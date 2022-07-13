//
//  MVVM.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation

enum ViewModelTable {
    static var viewModels = [String: AnyObject?]()
}

protocol View: AnyObject {
    associatedtype ViewModel

    func bind(to viewModel: ViewModel)
}

extension View {
    var identifier: String { .init(describing: self) }
    
    var viewModel: ViewModel? {
        get {
            guard let object = ViewModelTable.viewModels[identifier],
                  let viewModel = object as? ViewModel else {
                return nil
            }
            
            return viewModel
        } set {
            if let viewModel = newValue {
                bind(to: viewModel)
            }
            ViewModelTable.viewModels[identifier] = newValue as AnyObject?
        }
    }
}

protocol ViewModel: AnyObject {
    associatedtype Action
    associatedtype State

    var action: Action { get }
    var state: State { get }
}
