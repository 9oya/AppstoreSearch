//
//  RootBuilder.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    
}

final class RootComponent: Component<RootDependency> {
    
    let rootViewController: RootTabBarController

    init(dependency: RootDependency,
         rootViewController: RootTabBarController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootTabBarController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        
        let updateBuilder = UpdateBuilder(dependency: component)
        let searchBuilder = SearchBuilder(dependency: component)
        
        let router = RootRouter(interactor: interactor,
                                viewController: viewController,
                                searchBuilder: searchBuilder,
                                updateBuilder: updateBuilder)
        
        return router
    }
}
