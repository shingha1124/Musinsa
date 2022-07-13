//
//  HomeSectionHeaderView.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class HomeSectionHeaderView: UICollectionReusableView, View {
    static var identifier: String { .init(describing: self) }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let iconView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let seeAll: UIButton = {
        let button = UIButton()
        button.setTitle("전체", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: HomeSectionHeaderViewModel) {
        let header = viewModel.state.header
        title.text = header.title
        iconView.isHidden = header.iconURL == nil
        seeAll.isHidden = header.linkURL == nil
        
        if let iconUrl = header.iconURL {
            Task {
                icon.image = await ImageManager.shared.loadImage(url: iconUrl)
            }
        }
    }
    
    func layout() {
        addSubview(stackView)
        addSubview(seeAll)
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(title)
        iconView.addSubview(icon)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.lessThanOrEqualTo(250)
            $0.height.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
        icon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        seeAll.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(50)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
