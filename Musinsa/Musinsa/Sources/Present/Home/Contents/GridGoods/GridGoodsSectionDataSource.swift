//
//  BannerCollectionSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class GridGoodsSectionDataSource: SectionDataSource, View {
    
    private let item: NSCollectionLayoutItem = {
        let fractionalWidth = 1.0 / 3.0
        let fractionalHeight = fractionalWidth * 1.7
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .fractionalWidth(fractionalHeight)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        return item
    }()
    
    private lazy var group: NSCollectionLayoutGroup = {
        let width: NSCollectionLayoutDimension = .fractionalWidth(1)
        let height: NSCollectionLayoutDimension = .estimated(100)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        return group
    }()
    
    lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = .init(top: 5, leading: 10, bottom: 15, trailing: 10)
        section.decorationItems = [
            .background(elementKind: WidthInsetBackgroundView.identifier)
        ]
        return section
    }()
    
    var itemCount: Int {
        viewCount
    }
    
    private let disposeBag = DisposeBag()
    private var viewCount = 0
    
    func reloadSection() {
        
    }
    
    func bind(to viewModel: GridGoodsSectionViewModel) {
        makeHeaderItem(header: viewModel.state.header)
        makeFooterItem(footer: viewModel.state.footer)
        
        viewModel.state.itemCount
            .bind(onNext: { [weak self] count in
                self?.viewCount = count
            })
            .disposeBag(disposeBag)
        
        viewModel.action.loadData.accept(())
    }
}

extension GridGoodsSectionDataSource {
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridGoodsViewCell.identifier, for: indexPath) as? GridGoodsViewCell else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel?[indexPath.item]
        return cell
    }
    
    func supplementaryElement(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return reusableHeader(collectionView, indexPath: indexPath, model: viewModel?.state.header)
        case UICollectionView.elementKindSectionFooter:
            return reusableFooter(collectionView, indexPath: indexPath, model: viewModel?.state.footer)
        default:
            return UICollectionReusableView()
        }
    }
    
    func displaySupplementaryView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    }
}
