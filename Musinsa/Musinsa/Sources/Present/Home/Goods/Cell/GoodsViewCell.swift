//
//  BannerViewCell.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class GoodsViewCell: BaseCollectionViewCell, View {
        
    func bind(to viewModel: GoodsViewCellModel) {
        print("BannerViewCell")
        contentView.backgroundColor = .blue
    }
}
