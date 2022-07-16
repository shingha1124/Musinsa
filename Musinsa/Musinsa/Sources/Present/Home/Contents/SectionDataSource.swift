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
    
    func didLoad()
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func supplementaryElement(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
    func displaySupplementaryView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
}

extension SectionDataSource {
}
