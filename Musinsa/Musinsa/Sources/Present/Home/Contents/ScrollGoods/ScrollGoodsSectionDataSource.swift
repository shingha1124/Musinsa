//
//  BannerCollectionSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class ScrollGoodsSectionDataSource: SectionDataSource, HeaderUsable, View {
    
    private let item: NSCollectionLayoutItem = {
        let fractionalWidth = 1.0
        let fractionalHeight = 1.7
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .fractionalWidth(fractionalHeight)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0, leading: 2, bottom: 0, trailing: 2)
        return item
    }()
    
    private lazy var group: NSCollectionLayoutGroup = {
        let fractionalWidth = 1.0 / 2.7
        let width: NSCollectionLayoutDimension = .fractionalWidth(fractionalWidth)
        let height: NSCollectionLayoutDimension = .estimated(200)
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        return group
    }()
    
    lazy var section: NSCollectionLayoutSection = {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 5, leading: 10, bottom: 10, trailing: 10)
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
    
    func didLoad() {
    }
    
    func bind(to viewModel: ScrollGoodsSectionViewModel) {
        appendHeaderItem(section, header: viewModel.state.header)
        
        viewModel.state.itemCount
            .bind(onNext: { [weak self] count in
                self?.viewCount = count
            })
            .disposeBag(disposeBag)
        
        viewModel.action.loadData.accept(())
    }
}

extension ScrollGoodsSectionDataSource {
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollGoodsViewCell.identifier, for: indexPath) as? ScrollGoodsViewCell else {
            return UICollectionViewCell()
        }
        
        cell.viewModel = viewModel?[indexPath.item]
        return cell
    }
    
    func supplementaryElement(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return reusableHeader(collectionView, indexPath: indexPath, model: viewModel?.state.header)
        default:
            return UICollectionReusableView()
        }
    }
    
    func displaySupplementaryView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == WidthInsetBackgroundView.identifier {
            let backgroundView = view as? WidthInsetBackgroundView
            backgroundView?.widthInset(0)
        }
    }
}
