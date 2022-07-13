//
//  HomeSectionFooterView.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class HomeSectionFooterView: UICollectionReusableView, View {
    static var identifier: String { .init(describing: self) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: HomeSectionFooterViewModel) {
        
    }
}
