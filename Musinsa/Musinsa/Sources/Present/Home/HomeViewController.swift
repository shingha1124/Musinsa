//
//  ViewController.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

class HomeViewController: UIViewController, View {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        
        return collectionView
    }()
    
    private let collectionLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
            return nil
        }
        
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.action.viewDidLoad.accept(())
    }

    func bind(to viewModel: HomeViewModel) {
    }
}
