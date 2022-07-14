//
//  SectionBackgroundView.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import UIKit

class WidthInsetBackgroundView: UICollectionReusableView {
    static var identifier: String { .init(describing: self) }
    
    private var insetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(insetView)
        
        insetView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    func widthInset(_ value: Float) {        
        insetView.snp.updateConstraints {
            $0.leading.trailing.equalToSuperview().inset(value)
        }
    }
}
