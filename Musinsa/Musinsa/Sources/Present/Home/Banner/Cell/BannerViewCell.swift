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
    
    private let keyword: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        label.shadowColor = .black.withAlphaComponent(0.5)
        label.shadowOffset = CGSize(width: 0.3, height: 0.3)
        return label
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        label.shadowColor = .black.withAlphaComponent(0.5)
        label.shadowOffset = CGSize(width: 0.3, height: 0.3)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.textColor = .white
        label.shadowColor = .black.withAlphaComponent(0.5)
        label.shadowOffset = CGSize(width: 0.3, height: 0.3)
        return label
    }()
    
    func bind(to viewModel: BannerViewCellModel) {
        let banner = viewModel.state.banner
        Task {
            bannerView.image = await ImageManager.shared.loadImage(url: banner.thumbnailURL)
        }
        
        title.text = banner.title
        title.isHidden = banner.title.isEmpty
        descriptionLabel.text = banner.description
        descriptionLabel.isHidden = banner.description.isEmpty
        keyword.text = banner.keyword
        keyword.isHidden = banner.keyword.isEmpty
    }
    
    override func layout() {
        contentView.addSubview(bannerView)
        contentView.addSubview(keyword)
        contentView.addSubview(title)
        contentView.addSubview(descriptionLabel)
        
        bannerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(65)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        keyword.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(20)
        }
    }
}
