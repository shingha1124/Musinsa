//
//  ViewController.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController, View {
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
        viewModel.state.appendSection
            .bind(onNext: dataSource.appendModel(_:))
            .disposeBag(disposeBag)

        viewModel.state.reloadData
            .mainThread()
            .bind(onNext: collectionView.reloadData)
            .disposeBag(disposeBag)
    }
    
    func attribute() {
        view.backgroundColor = .backGround2
    }
    
    func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
