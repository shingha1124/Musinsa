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
        return imageView
    }()
        
    func bind(to viewModel: StyleViewCellModel) {
        let goods = viewModel.state.style
        Task {
            thumbnailView.image = await ImageManager.shared.loadImage(url: goods.thumbnailURL)
        }
    }
    
    override func layout() {
        contentView.addSubview(thumbnailView)
        
        thumbnailView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }
    }
}
