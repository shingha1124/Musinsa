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
    
    private let finishLabel: UILabel = {
        let label = UILabel()
        label.text = "상품이 더 이상 없습니다!"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private var disposeBag = DisposeBag()
    
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
        disposeBag = DisposeBag()
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
        
        viewModel.state.isMax
            .bind(onNext: { [weak self] isMax in
                self?.button.isHidden = isMax
                self?.finishLabel.isHidden = !isMax
            })
            .disposeBag(disposeBag)
        
        viewModel.action.loadData.accept(())
    }
    
    private func layout() {
        addSubview(finishLabel)
        addSubview(button)
        
        finishLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(36)
        }
    }
}
