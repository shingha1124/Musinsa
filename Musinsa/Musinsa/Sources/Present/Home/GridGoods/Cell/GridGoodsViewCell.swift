//
//  BannerViewCell.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class GridGoodsViewCell: BaseCollectionViewCell, View {
    
    private let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    func bind(to viewModel: GridGoodsViewCellModel) {
        let goods = viewModel.state.goods
        Task {
            guard let image = try? await ImageManager.shared.loadImage(url: goods.thumbnailURL) else {
                return
            }
            
            thumbnailView.image = image
        }
    }
    
    override func layout() {
        contentView.addSubview(thumbnailView)
        
        thumbnailView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }
    }
}
