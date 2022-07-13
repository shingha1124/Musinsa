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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let brandName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let coupon: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "쿠폰"
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        label.clipsToBounds = true
        label.layer.cornerRadius = 3
        return label
    }()
    
    func bind(to viewModel: GridGoodsViewCellModel) {
        let goods = viewModel.state.goods
        Task {
            thumbnailView.image = await ImageManager.shared.loadImage(url: goods.thumbnailURL)
        }
        
        priceLabel.text = goods.price.convertToKRW(true)
        brandName.text = goods.brandName
    }
    
    override func layout() {
        contentView.addSubview(thumbnailView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(brandName)
        contentView.addSubview(coupon)
        
        thumbnailView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.width.equalToSuperview().inset(2)
            $0.bottom.equalTo(priceLabel.snp.top).offset(-5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        brandName.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(priceLabel.snp.top).offset(-5)
        }
        
        coupon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalTo(brandName.snp.top).offset(-5)
        }
    }
}
