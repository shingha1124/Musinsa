//
//  HeaderUsable.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/16.
//

import UIKit

protocol HeaderUsable {
}

extension HeaderUsable {
    func appendHeaderItem(_ section: NSCollectionLayoutSection, header: HomeSectionHeaderViewModel?) {
        if header == nil {
            return
        }
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45.0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems.append(headerItem)
    }
    
    func reusableHeader(_ collectionView: UICollectionView, indexPath: IndexPath, model: HomeSectionHeaderViewModel?) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.identifier, for: indexPath) as? HomeSectionHeaderView,
              let model = model else {
            return UICollectionReusableView()
        }
        header.viewModel = model
        return header
    }
}
