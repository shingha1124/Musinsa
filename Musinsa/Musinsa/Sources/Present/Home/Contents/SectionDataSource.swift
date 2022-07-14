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
    var header: HomeSectionHeaderViewModel? { get }
    var footer: HomeSectionFooterViewModel? { get }
    var type: Contents.`Type` { get }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
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
}
