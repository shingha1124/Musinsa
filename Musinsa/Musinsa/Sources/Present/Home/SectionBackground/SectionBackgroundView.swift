//
//  SectionBackgroundView.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    static var identifier: String { .init(describing: self) }

    private var insetView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
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
            $0.edges.equalToSuperview().inset(5)
        }
    }
}
