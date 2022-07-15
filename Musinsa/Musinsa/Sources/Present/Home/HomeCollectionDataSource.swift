//
//  HomeCollectionDataSource.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class HomeCollectionDataSource: NSObject {
    private var sectionDataSources = [SectionDataSource]()
    
    func appendModel(_ models: [SectionViewModel]) {
        models.forEach { model in
            switch model.type {
            case .banner:
                let dataSource = BannerSectionDataSource()
                dataSource.viewModel = model as? BannerSectionViewModel
                sectionDataSources.append(dataSource)
            case .grid:
                let dataSource = GridGoodsSectionDataSource()
                dataSource.viewModel = model as? GridGoodsSectionViewModel
                sectionDataSources.append(dataSource)
            case .scroll:
                let dataSource = ScrollGoodsSectionDataSource()
                dataSource.viewModel = model as? ScrollGoodsSectionViewModel
                sectionDataSources.append(dataSource)
            case .style:
                let dataSource = StyleSectionDataSource()
                dataSource.viewModel = model as? StyleSectionViewModel
                sectionDataSources.append(dataSource)
            }
        }
    }
    
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        sectionDataSources[section].section
    }
}

extension HomeCollectionDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        sectionDataSources[indexPath.section].displaySupplementaryView(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
    }
}

extension HomeCollectionDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionDataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sectionDataSources[section].itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sectionDataSources[indexPath.section].dequeueReusableCell(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        sectionDataSources[indexPath.section].supplementaryElement(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}
