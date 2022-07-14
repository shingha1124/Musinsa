//
//  BannerCollectionSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation
import UIKit

final class GridGoodsSectionDataSource: SectionDataSource {
    
    private let item: NSCollectionLayoutItem = {
        let fractionalWidth = 1.0 / 3.0
        let fractionalHeight = fractionalWidth * 1.7
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .fractionalWidth(fractionalHeight)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        return item
    }()
    
    private lazy var group: NSCollectionLayoutGroup = {
        let width: NSCollectionLayoutDimension = .fractionalWidth(1)
        let height: NSCollectionLayoutDimension = .estimated(100)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        return group
    }()
    
    lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = .init(top: 5, leading: 10, bottom: 15, trailing: 10)
        section.decorationItems = [
            .background(elementKind: WidthInsetBackgroundView.identifier)
        ]
        return section
    }()
    
    var itemCount: Int {
        currentViewCount
    }
    
    var header: HomeSectionHeaderViewModel? {
        viewModel.header
    }
    
    var footer: HomeSectionFooterViewModel? {
        viewModel.footer
    }
    
    var type: Contents.`Type` {
        viewModel.type
    }
    
    private let viewModel: SectionViewModel
    private let disposeBag = DisposeBag()
    
    private let addViewCount = 6
    private var currentViewCount = 6
    
    init(sectionViewModel: SectionViewModel) {
        viewModel = sectionViewModel
        makeHeaderItem(header: sectionViewModel.header)
        makeFooterItem(footer: sectionViewModel.footer)
        
        viewModel.addViewCount
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                let stackCount = self.currentViewCount + self.addViewCount
                self.currentViewCount = min(stackCount, self.viewModel.count)
            })
            .disposeBag(disposeBag)
    }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridGoodsViewCell.identifier, for: indexPath) as? GridGoodsViewCell else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel[indexPath.item]
        return cell
    }
}
