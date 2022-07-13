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
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
