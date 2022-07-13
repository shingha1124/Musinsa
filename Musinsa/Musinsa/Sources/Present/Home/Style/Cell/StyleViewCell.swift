//
//  BannerViewCell.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class StyleViewCell: BaseCollectionViewCell, View {
        
    func bind(to viewModel: StyleViewCellModel) {
        print("BannerViewCell")
        contentView.backgroundColor = .green
    }
}
