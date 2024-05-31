//
//  TabCoordinator.swift
//  
//
//  Created by Ivan B on 16.05.23.
//

import UIKit

protocol TabCoordinatorInterface: Coordinatable {
    func selectPage(_ page: TabCoordinator.TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabCoordinator.TabBarPage?
}

protocol TabCoordinatorDelegate: AnyObject {
    func didLogoutUser(_ coordinator: TabCoordinator)
}

final class TabCoordinator: BaseCoordinator {
    
    enum TabBarPage: Int, CaseIterable {
        case TAB_NAME

        fileprivate var tabBarItem: UITabBarItem {
            switch self {
            case .TAB_NAME:
                return UITabBarItem(
                    title: "",
                    image: nil,
                    selectedImage: nil
                )
            }
        }
    }

    weak var delegate: TabCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private let tabBarController: UITabBarController

    required init(
        navigationController: BaseNavigationController,
        delegate: TabCoordinatorDelegate?
    ) {
        self.delegate = delegate
        self.navigationController = navigationController
        tabBarController = UITabBarController()
        super.init(router: Router(rootController: navigationController))
        startingViewController = tabBarController
        navigationController.isNavigationBarHidden = true
        setupAppearance()
    }

    override func start() {
        let controllers: [UINavigationController] = TabBarPage.allCases.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
        UIView.transition(
            with: self.navigationController.view,
            duration: AnimationDuration.macroRegular.timeInterval,
            options: .transitionCrossDissolve,
            animations: {
                self.router.setRootModule(self.tabBarController, hideBar: true)
            },
            completion: nil
        )
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: false)
        tabBarController.selectedIndex = TabBarPage.allCases.first?.rawValue ?? 0
    }
    
    private func setupAppearance() {
        //... template implementation
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = BaseNavigationController()
        navigationController.tabBarItem = page.tabBarItem
        /*

        let router = Router(rootController: navigationController)
        switch page {
        case .map:
            let COORDINATOR_NAME = COORDINATOR(router: router)
            COORDINATOR_NAME.parent = self
            children.append(COORDINATOR_NAME)
            COORDINATOR_NAME.start()
        }
         */
        return navigationController
    }
}

extension TabCoordinator: TabCoordinatorInterface {
    func currentPage() -> TabBarPage? {
        TabBarPage(rawValue: tabBarController.selectedIndex)
    }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.rawValue
    }

    func setSelectedIndex(_ index: Int) {
        tabBarController.selectedIndex = index
    }
}
