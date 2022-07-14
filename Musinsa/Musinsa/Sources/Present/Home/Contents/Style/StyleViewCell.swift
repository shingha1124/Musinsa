//
//  BannerViewCell.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class StyleViewCell: BaseCollectionViewCell, View {
    
    private let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let button = UIButton()
        
    func bind(to viewModel: SectionCellViewModel) {
        guard let style = viewModel.state.content as? Style else {
            return
        }
        Task {
            thumbnailView.image = await ImageManager.shared.loadImage(url: style.thumbnailURL)
        }
        
        button.addAction(UIAction { _ in
            viewModel.action.tappedContent.accept(style)
        }, for: .touchUpInside)
    }
    
    override func layout() {
        contentView.addSubview(thumbnailView)
        contentView.addSubview(button)
        
        thumbnailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
