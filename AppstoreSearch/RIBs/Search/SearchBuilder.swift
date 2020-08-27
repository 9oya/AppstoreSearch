//
//  SearchBuilder.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol SearchDependency: Dependency {
    
}

final class SearchComponent: Component<SearchDependency> {

    override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol SearchBuildable: Buildable {
    func build(withListener listener: SearchListener) -> SearchRouting
}

final class SearchBuilder: Builder<SearchDependency>, SearchBuildable {

    override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchListener) -> SearchRouting {
        let component = SearchComponent(dependency: dependency)
        let viewController = SearchViewController(nibName: "SearchViewController", bundle: Bundle.main)
        let interactor = SearchInteractor(presenter: viewController)
        interactor.listener = listener
        
        let searchDetailBuilder = SearchDetailBuilder(dependency: component)
        
        return SearchRouter(interactor: interactor,
                            viewController: viewController,
                            searchDetailBuilder: searchDetailBuilder)
    }
}
