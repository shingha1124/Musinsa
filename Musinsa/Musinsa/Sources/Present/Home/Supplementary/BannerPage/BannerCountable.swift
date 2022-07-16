//
//  BannerCountable.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/16.
//

import UIKit

protocol BannerCountable {
}

extension BannerCountable {
    func appendBannerCountItem(_ section: NSCollectionLayoutSection) {
        let anchor = NSCollectionLayoutAnchor(edges: [.bottom, .trailing],
                                              absoluteOffset: CGPoint(x: 0, y: -10))
        
        let pageItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45.0)), elementKind: BannerPageCountingView.elementKind, containerAnchor: anchor)
        section.boundarySupplementaryItems.append(pageItem)
    }
    
    func reusableBannerCount(_ collectionView: UICollectionView, indexPath: IndexPath, model: BannerPageCountingViewModel?) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: BannerPageCountingView.elementKind, withReuseIdentifier: BannerPageCountingView.identifier, for: indexPath) as? BannerPageCountingView else {
            return UICollectionReusableView()
        }
        view.viewModel = model
        return view
    }
}
