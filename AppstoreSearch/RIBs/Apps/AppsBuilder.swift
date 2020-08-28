//
//  AppsBuilder.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol AppsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppsComponent: Component<AppsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppsBuildable: Buildable {
    func build(withListener listener: AppsListener) -> AppsRouting
}

final class AppsBuilder: Builder<AppsDependency>, AppsBuildable {

    override init(dependency: AppsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AppsListener) -> AppsRouting {
        let _ = AppsComponent(dependency: dependency)
        let viewController = AppsViewController()
        
        let interactor = AppsInteractor(presenter: viewController)
        interactor.listener = listener
        return AppsRouter(interactor: interactor, viewController: viewController)
    }
}
