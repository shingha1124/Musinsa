//
//  SceneDelegate.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.overrideUserInterfaceStyle = .light
        
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()
        viewController.viewModel = viewModel
        
        let rootViewController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
