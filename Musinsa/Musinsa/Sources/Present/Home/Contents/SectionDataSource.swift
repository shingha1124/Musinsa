//
//  SectionView.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

protocol SectionDataSource {
    var section: NSCollectionLayoutSection { get }
    var itemCount: Int { get }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func supplementaryElement(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
    func displaySupplementaryView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
}

extension SectionDataSource {
    
    func makeHeaderItem(header: HomeSectionHeaderViewModel?) {
        if header == nil {
            return
        }
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45.0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems.append(headerItem)
    }
    
    func makeFooterItem(footer: HomeSectionFooterViewModel?) {
        if footer == nil {
            return
        }
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50.0)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems.append(footerItem)
    }
    
    func reusableHeader(_ collectionView: UICollectionView, indexPath: IndexPath, model: HomeSectionHeaderViewModel?) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.identifier, for: indexPath) as? HomeSectionHeaderView,
              let model = model else {
            return UICollectionReusableView()
        }
        header.viewModel = model
        return header
    }
    
    func reusableFooter(_ collectionView: UICollectionView, indexPath: IndexPath, model: HomeSectionFooterViewModel?) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeSectionFooterView.identifier, for: indexPath) as? HomeSectionFooterView,
              let model = model else {
            return UICollectionReusableView()
        }
        footer.viewModel = model
        return footer
    }
}
