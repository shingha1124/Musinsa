//
//  BannerCollectionSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import Foundation
import UIKit

final class StyleSectionDataSource: SectionDataSource {
    
    private let item: NSCollectionLayoutItem = {
        let fractionalWidth = 1.0 / 2.0
        let fractionalHeight = fractionalWidth * 1.5
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .fractionalWidth(fractionalHeight)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        return item
    }()
    
    private lazy var group: NSCollectionLayoutGroup = {
        let width: NSCollectionLayoutDimension = .fractionalWidth(1)
        let height: NSCollectionLayoutDimension = .estimated(200)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        return group
    }()
    
    lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 5, leading: 10, bottom: 15, trailing: 10)
        section.decorationItems = [
            .background(elementKind: WidthInsetBackgroundView.identifier)
        ]
        return section
    }()
    
    var itemCount: Int {
        currentViewCount
//        let count = viewModel?.count ?? 0
//        return count > 4 ? 4 : count
    }
    
    var header: HomeSectionHeaderViewModel? {
        viewModel.header
    }
    
    var footer: HomeSectionFooterViewModel? {
        viewModel.footer
    }
    
    var type: Contents.`Type` {
        viewModel.type
    }
    
    private let viewModel: SectionViewModel
    private let disposeBag = DisposeBag()
    
    private let addViewCount = 4
    private var currentViewCount = 4
    
    init(sectionViewModel: SectionViewModel) {
        viewModel = sectionViewModel
        makeHeaderItem(header: sectionViewModel.header)
        makeFooterItem(footer: sectionViewModel.footer)
        
        currentViewCount = min(viewModel.count, addViewCount)
        
        viewModel.addViewCount
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                let stackCount = self.currentViewCount + self.addViewCount
                self.currentViewCount = min(stackCount, self.viewModel.count)
            })
            .disposeBag(disposeBag)
    }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleViewCell.identifier, for: indexPath) as? StyleViewCell else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel[indexPath.item]
        return cell
    }
}
