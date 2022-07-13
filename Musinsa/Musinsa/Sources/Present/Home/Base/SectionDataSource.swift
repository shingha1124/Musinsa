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
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

extension SectionDataSource {
    func makeBoundarySupplementaryItem(sectionViewModel: SectionViewModel) {
        if sectionViewModel.header != nil {
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70.0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
            section.boundarySupplementaryItems.append(header)
        }
        
        if (sectionViewModel.type != .banner && sectionViewModel.type != .scroll),
            sectionViewModel.footer != nil {
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70.0)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            section.boundarySupplementaryItems.append(footer)
        }
        
        section.decorationItems = [
            .background(elementKind: SectionBackgroundView.identifier),
        ]
    }
}
