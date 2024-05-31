//
//  AppCoordinator.swift
//  
//
//  Created by  Ivan B  on 16.05.23.
//

import UIKit

protocol SplashSceneOutput: AnyObject {
    func proceedFromSplash()
}

protocol ApplicationCoordinatorInterface: Coordinatable {
    func startLoginFlow()
    func startAuthorizedFlow()
}

final class AppCoordinator: BaseCoordinator {
    
    private weak var window: UIWindow?
    
    init(window: UIWindow) {
        let navigationController = BaseNavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        super.init(router: Router(rootController: navigationController))
    }
    
    override func start() {
        router.setRootModule(SplashAssembly(sceneOutput: self).makeScene())
    }
    
}

extension AppCoordinator: ApplicationCoordinatorInterface {
    func startAuthorizedFlow() {
        DispatchQueue.main.async {
            let tabCoordinator = TabCoordinator(
                navigationController: self.router.root,
                delegate: self
            )
            self.add(tabCoordinator)
            tabCoordinator.start()
        }
    }
    
    func startLoginFlow() {}
}

extension AppCoordinator: TabCoordinatorDelegate {
    func didLogoutUser(_ coordinator: TabCoordinator) {
        DispatchQueue.main.async {
            self.startLoginFlow()
            self.remove(coordinator)
        }
    }
}

extension AppCoordinator: SplashSceneOutput {
    func proceedFromSplash() {
        startAuthorizedFlow()
    }
}

