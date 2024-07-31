//
//  SceneDelegate.swift
//  subscription
//
//  Created by Filipe Marques on 31/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coreDataManager: CoreDataManagerProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // MARK: - Core Data Implementation
        coreDataManager = CoreDataManager.shared

        if let coreDataManager {
            let viewModel = SubscriptionViewModel(coreDataManager: coreDataManager)
            let viewController = SubscriptionViewController(viewModel: viewModel)
            let window = UIWindow(windowScene: windowScene)

            window.rootViewController = viewController
            window.makeKeyAndVisible()

            self.window = window
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        coreDataManager?.saveContext()
    }


}

