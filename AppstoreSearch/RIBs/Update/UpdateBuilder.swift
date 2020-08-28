//
//  UpdateBuilder.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol UpdateDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class UpdateComponent: Component<UpdateDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol UpdateBuildable: Buildable {
    func build(withListener listener: UpdateListener) -> UpdateRouting
}

final class UpdateBuilder: Builder<UpdateDependency>, UpdateBuildable {

    override init(dependency: UpdateDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: UpdateListener) -> UpdateRouting {
        let _ = UpdateComponent(dependency: dependency)
        let viewController = UpdateViewController(nibName: "UpdateViewController", bundle: Bundle.main)
        
        let interactor = UpdateInteractor(presenter: viewController)
        interactor.listener = listener
        return UpdateRouter(interactor: interactor, viewController: viewController)
    }
}
