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
            section.boundarySupplementaryItems.append(
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50.0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
            )
        }
        
        if (sectionViewModel.type != .banner && sectionViewModel.type != .scroll),
            sectionViewModel.footer != nil {
            section.boundarySupplementaryItems.append(
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50.0)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            )
        }
    }
}
