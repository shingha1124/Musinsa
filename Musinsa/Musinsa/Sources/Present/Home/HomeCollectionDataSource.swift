//
//  HomeCollectionDataSource.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class HomeCollectionDataSource: NSObject {
    private var models = [SectionDataSource]()
    
    func appendModel(_ model: SectionViewModel) {
        switch model.type {
        case .banner:
            models.append(BannerSectionDataSource(sectionViewModel: model))
        case .grid:
            models.append(GridGoodsSectionDataSource(sectionViewModel: model))
        case .scroll:
            models.append(ScrollGoodsSectionDataSource(sectionViewModel: model))
        case .style:
            models.append(StyleSectionDataSource(sectionViewModel: model))
        }
    }
    
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        models[section].section
    }
}

extension HomeCollectionDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == WidthInsetBackgroundView.identifier {
            let backgroundView = view as? WidthInsetBackgroundView
            backgroundView?.sectionType(models[indexPath.section].type)
        }
//        models[indexPath.section].willDisplaySupplementaryView(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
    }
}

extension HomeCollectionDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models[section].itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        models[indexPath.section].dequeueReusableCell(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionHeaderView.identifier, for: indexPath) as? HomeSectionHeaderView else {
                return UICollectionReusableView()
            }
            header.viewModel = models[indexPath.section].header
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionFooterView.identifier, for: indexPath) as? HomeSectionFooterView else {
                return UICollectionReusableView()
            }
            footer.viewModel = models[indexPath.section].footer
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}
