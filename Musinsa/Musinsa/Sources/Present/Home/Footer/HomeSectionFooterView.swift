//
//  HomeSectionFooterView.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class HomeSectionFooterView: UICollectionReusableView, View {
    static var identifier: String { .init(describing: self) }
    
    private let button: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.imagePadding = 5
        config.baseForegroundColor = .black.withAlphaComponent(0.8)
        config.baseBackgroundColor = .white
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.removeTarget(nil, action: nil, for: .allEvents)
    }
    
    func bind(to viewModel: HomeSectionFooterViewModel) {
        let footer = viewModel.state.footer
                
        if let iconUrl = footer.iconURL {
            Task {
                var iconImage = await ImageManager.shared.loadImage(url: iconUrl)
                iconImage = iconImage?.resizeImage(to: CGSize(width: 20, height: 20))
                button.configuration?.image = iconImage
            }
        }
        
        button.configuration?.title = footer.title
        
        button.addAction(UIAction { _ in
            viewModel.action.tappedFooter.accept(footer)
        }, for: .touchUpInside)
    }
    
    func layout() {
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(36)
        }
    }
}
