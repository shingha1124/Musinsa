//
//  HomeCollectionDataSource.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class HomeCollectionDataSource: NSObject {
    private var models = [SectionDataSource]()
    
    var layout: UICollectionViewCompositionalLayout {
        collectionLayout
    }
    
    private lazy var collectionLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: self.layoutSection)
        return layout
    }()
}

extension HomeCollectionDataSource {
    
    func appendModel(_ model: SectionViewModel) {
        switch model.type {
        case .banner:
            models.append(BannerSectionDataSource(sectionViewModel: model))
        case .grid:
            models.append(GoodsSectionDataSource(sectionViewModel: model))
        case .scroll:
            models.append(GoodsSectionDataSource(sectionViewModel: model))
        case .style:
            models.append(StyleSectionDataSource(sectionViewModel: model))
        }
    }
    
    private func layoutSection(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        models[section].section
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
}
