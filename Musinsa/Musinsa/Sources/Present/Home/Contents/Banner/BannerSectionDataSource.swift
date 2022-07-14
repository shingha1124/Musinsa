//
//  BannerCollectionSection.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class BannerSectionDataSource: SectionDataSource, View {
    
    private let item: NSCollectionLayoutItem = {
        let width: NSCollectionLayoutDimension = .fractionalWidth(1)
        let height: NSCollectionLayoutDimension = .fractionalWidth(1)
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
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)

        section.visibleItemsInvalidationHandler = { cells, scrollOffset, _ in
            let page = Int(round(scrollOffset.x / cells[0].frame.width)) + 1
            self.viewModel?.action.changePage.accept(page)
        }
        
        let anchor = NSCollectionLayoutAnchor(edges: [.bottom, .trailing],
                                              absoluteOffset: CGPoint(x: 0, y: -10))
        
        let pageItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45.0)), elementKind: BannerPageCountingView.elementKindSection, containerAnchor: anchor)
        section.boundarySupplementaryItems.append(pageItem)
        
        return section
    }()
    
    var itemCount: Int {
        viewCount
    }
    
    private let disposeBag = DisposeBag()
    private var viewCount = 0
    
    func bind(to viewModel: BannerSectionViewModel) {
        viewModel.state.itemCount
            .bind(onNext: { [weak self] count in
                self?.viewCount = count
            })
            .disposeBag(disposeBag)
        
        viewModel.action.loadData.accept(())
    }
}

extension BannerSectionDataSource {
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCell.identifier, for: indexPath) as? BannerViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel?[indexPath.item]
        return cell
    }
    
    func supplementaryElement(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case BannerPageCountingView.elementKindSection:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerPageCountingView.identifier, for: indexPath) as? BannerPageCountingView else {
                return UICollectionReusableView()
            }
            view.viewModel = viewModel?.state.bannerCounting
            return view
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
