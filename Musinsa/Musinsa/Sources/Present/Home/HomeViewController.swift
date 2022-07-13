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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: dataSource.layout)
        
        collectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: BannerViewCell.identifier)
        collectionView.register(GridGoodsViewCell.self, forCellWithReuseIdentifier: GridGoodsViewCell.identifier)
        collectionView.register(ScrollGoodsViewCell.self, forCellWithReuseIdentifier: ScrollGoodsViewCell.identifier)
        collectionView.register(StyleViewCell.self, forCellWithReuseIdentifier: StyleViewCell.identifier)
        return collectionView
    }()
    
    private let dataSource = HomeCollectionDataSource()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        collectionView.dataSource = dataSource
        
        viewModel?.action.viewDidLoad.accept(())
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
    
    func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
