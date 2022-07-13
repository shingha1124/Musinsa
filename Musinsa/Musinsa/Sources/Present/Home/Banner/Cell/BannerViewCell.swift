//
//  BannerViewCell.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class BannerViewCell: BaseCollectionViewCell, View {
    
    private let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    func bind(to viewModel: BannerViewCellModel) {
    }
    
    override func layout() {
        contentView.addSubview(bannerView)
        
        bannerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
