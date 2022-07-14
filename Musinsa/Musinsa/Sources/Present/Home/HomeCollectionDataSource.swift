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
            let dataSource = BannerSectionDataSource()
            dataSource.viewModel = model as? BannerSectionViewModel
            models.append(dataSource)
        case .grid:
            let dataSource = GridGoodsSectionDataSource()
            dataSource.viewModel = model as? GridGoodsSectionViewModel
            models.append(dataSource)
        case .scroll:
            let dataSource = ScrollGoodsSectionDataSource()
            dataSource.viewModel = model as? ScrollGoodsSectionViewModel
            models.append(dataSource)
        case .style:
            let dataSource = StyleSectionDataSource()
            dataSource.viewModel = model as? StyleSectionViewModel
            models.append(dataSource)
        }
    }
    
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        models[section].section
    }
}

extension HomeCollectionDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        models[indexPath.section].displaySupplementaryView(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
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
        models[indexPath.section].supplementaryElement(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}
