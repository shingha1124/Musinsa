//
//  BannerCollectionSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation
import UIKit

final class ScrollGoodsSectionDataSource: SectionDataSource {
    
    private let item: NSCollectionLayoutItem = {
        let fractionalWidth = 1.0
        let fractionalHeight = 1.5
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .fractionalWidth(fractionalHeight)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: 2, bottom: 0, trailing: 2)
        return item
    }()
    
    private lazy var group: NSCollectionLayoutGroup = {
        let fractionalWidth = 1.0 / 2.7
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .estimated(200)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        return group
    }()
    
    lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 5, leading: 10, bottom: 10, trailing: 10)
        return section
    }()
    
    var itemCount: Int {
        viewModel?.count ?? 0
    }
    
    var header: HomeSectionHeaderViewModel? {
        viewModel?.header
    }
    
    var footer: HomeSectionFooterViewModel? {
        viewModel?.footer
    }
    
    private let viewModel: ScrollGoodsSectionViewModel?
    
    init(sectionViewModel: SectionViewModel) {
        viewModel = sectionViewModel as? ScrollGoodsSectionViewModel
        makeBoundarySupplementaryItem(sectionViewModel: sectionViewModel)
    }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollGoodsViewCell.identifier, for: indexPath) as? ScrollGoodsViewCell else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel?[indexPath.item]
        return cell
    }
}
