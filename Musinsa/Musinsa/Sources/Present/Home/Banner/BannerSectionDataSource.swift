//
//  BannerCollectionSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation
import UIKit

final class BannerSectionDataSource: SectionDataSource {
    
    private let item: NSCollectionLayoutItem = {
        let width: NSCollectionLayoutDimension = .fractionalWidth(1)
        let height: NSCollectionLayoutDimension = .fractionalWidth(1)
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
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }()
    
    var itemCount: Int {
        viewModel?.count ?? 0
    }
    
    private let viewModel: BannerSectionViewModel?
    
    init(sectionViewModel: SectionViewModel) {
        viewModel = sectionViewModel as? BannerSectionViewModel
    }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCell.identifier, for: indexPath) as? BannerViewCell else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel?[indexPath.item]
        return cell
    }
}
