//
//  TestView.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import UIKit

class BannerPageCountingView: UICollectionReusableView, View {
    static var identifier: String { .init(describing: self) }
    static var elementKind: String { .init(describing: self) }
    
    private let countingLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = .white
        label.backgroundColor = .black.withAlphaComponent(0.6)
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.padding = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        label.isCapsule = true
        label.text = "1 / 20"
        return label
    }()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: BannerPageCountingViewModel) {
        viewModel.state.page
            .bind(onNext: { [weak self] current, max in
                self?.countingLabel.text = "\(current) / \(max)"
            })
            .disposeBag(disposeBag)
    }
    
    private func layout() {
        addSubview(countingLabel)
        
        countingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }
    }
}
