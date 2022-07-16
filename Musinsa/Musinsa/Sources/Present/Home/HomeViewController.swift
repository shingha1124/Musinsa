//
//  ViewController.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import SnapKit
import UIKit

final class HomeViewController: UIViewController, View {
    private lazy var collectionView: UICollectionView = {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: dataSource.sectionProvider, configuration: layoutConfig)
        
        layout.register(WidthInsetBackgroundView.self, forDecorationViewOfKind: WidthInsetBackgroundView.identifier)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: BannerViewCell.identifier)
        collectionView.register(GridGoodsViewCell.self, forCellWithReuseIdentifier: GridGoodsViewCell.identifier)
        collectionView.register(ScrollGoodsViewCell.self, forCellWithReuseIdentifier: ScrollGoodsViewCell.identifier)
        collectionView.register(StyleViewCell.self, forCellWithReuseIdentifier: StyleViewCell.identifier)
        
        collectionView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.identifier)
        collectionView.register(HomeSectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeSectionFooterView.identifier)
        
        collectionView.register(BannerPageCountingView.self, forSupplementaryViewOfKind: BannerPageCountingView.elementKind, withReuseIdentifier: BannerPageCountingView.identifier)
        
        collectionView.backgroundColor = .backGround2
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let dataSource = HomeCollectionDataSource()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        viewModel?.action.viewDidLoad.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func bind(to viewModel: HomeViewModel) {
        viewModel.state.appendSections
            .mainQueue()
            .bind(onNext: { [weak self] models in
                self?.dataSource.appendModel(models)
                self?.collectionView.reloadData()
                self?.dataSource.didLoad()
            })
            .disposeBag(disposeBag)

        viewModel.state.reloadData
            .mainQueue()
            .bind(onNext: collectionView.reloadData)
            .disposeBag(disposeBag)
        
        viewModel.state.reloadItems
            .bind(onNext: collectionView.reloadItems(at:))
            .disposeBag(disposeBag)
        
        viewModel.state.insertItems
            .bind(onNext: collectionView.insertItems(at:))
            .disposeBag(disposeBag)
        
        viewModel.state.openUrl
            .bind(onNext: {
                UIApplication.shared.open($0)
            })
            .disposeBag(disposeBag)
        
        viewModel.state.scrollToItem
            .mainQueue()
            .bind(onNext: { indexPath, animate in
                self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: animate)
            })
            .disposeBag(disposeBag)
    }
    
    private func attribute() {
        view.backgroundColor = .backGround2
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
