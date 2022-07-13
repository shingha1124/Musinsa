//
//  BannerViewCell.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class BannerViewCell: BaseCollectionViewCell, View {
    
    private let bannerView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    func bind(to viewModel: BannerViewCellModel) {
        let banner = viewModel.state.banner
        Task {
            guard let image = try? await ImageManager.shared.loadImage(url: banner.thumbnailURL) else {
                return
            }
            
            bannerView.image = image
        }
    }
    
    override func layout() {
        contentView.addSubview(bannerView)
        
        bannerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
