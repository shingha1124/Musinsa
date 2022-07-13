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
        let fractionalHeight = fractionalWidth * 1.5
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .fractionalWidth(fractionalHeight)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        return item
    }()
    
    private lazy var group: NSCollectionLayoutGroup = {
        let width: NSCollectionLayoutDimension = .fractionalWidth(1)
        let height: NSCollectionLayoutDimension = .estimated(200)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        return group
    }()
    
    lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 3, bottom: 0, trailing: 3)
        return section
    }()
    
    var itemCount: Int {
        let count = viewModel?.count ?? 0
        return count > 6 ? 6 : count
    }
    
    private let viewModel: GridGoodsSectionViewModel?
    
    init(sectionViewModel: SectionViewModel) {
        viewModel = sectionViewModel as? GridGoodsSectionViewModel
    }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridGoodsViewCell.identifier, for: indexPath) as? GridGoodsViewCell else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel?[indexPath.item]
        return cell
    }
}
