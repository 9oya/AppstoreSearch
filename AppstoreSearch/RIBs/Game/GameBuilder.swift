//
//  GameBuilder.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol GameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class GameComponent: Component<GameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol GameBuildable: Buildable {
    func build(withListener listener: GameListener) -> GameRouting
}

final class GameBuilder: Builder<GameDependency>, GameBuildable {

    override init(dependency: GameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: GameListener) -> GameRouting {
        let _ = GameComponent(dependency: dependency)
        let viewController = GameViewController()
        
        let interactor = GameInteractor(presenter: viewController)
        interactor.listener = listener
        return GameRouter(interactor: interactor, viewController: viewController)
    }
}
