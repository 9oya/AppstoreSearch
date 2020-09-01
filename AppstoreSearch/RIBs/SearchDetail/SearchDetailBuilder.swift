//
//  SearchDetailBuilder.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol SearchDetailDependency: Dependency {
}

final class SearchDetailComponent: Component<SearchDetailDependency> {
    fileprivate var itunseModel: ItunseModel
    
    init(dependency: SearchDetailDependency, itunseModel: ItunseModel) {
        self.itunseModel = itunseModel
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol SearchDetailBuildable: Buildable {
    func build(withListener listener: SearchDetailListener, itunseModel: ItunseModel) -> SearchDetailRouting
}

final class SearchDetailBuilder: Builder<SearchDetailDependency>, SearchDetailBuildable {

    override init(dependency: SearchDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchDetailListener, itunseModel: ItunseModel) -> SearchDetailRouting {
        let component = SearchDetailComponent(dependency: dependency, itunseModel: itunseModel)
        let viewController = SearchDetailViewController(nibName: "SearchDetailViewController", bundle: Bundle.main)
        let interactor = SearchDetailInteractor(presenter: viewController,
                                                itunseModel: component.itunseModel)
        interactor.listener = listener
        return SearchDetailRouter(interactor: interactor, viewController: viewController)
    }
}
