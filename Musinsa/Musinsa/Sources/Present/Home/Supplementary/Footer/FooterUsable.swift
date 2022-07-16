//
//  HomeSectionFooterProtocol.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/16.
//

import UIKit

protocol FooterUsable {
}

extension FooterUsable {
    func appendFooterItem(_ section: NSCollectionLayoutSection, footer: HomeSectionFooterViewModel?) {
        if footer == nil {
            return
        }
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50.0)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems.append(footerItem)
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
