//
//  SearchRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol SearchInteractable: Interactable, SearchDetailListener {
    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
}

protocol SearchViewControllable: ViewControllable {
    func pushToSearchDetail(viewController: ViewControllable?)
}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SearchInteractable,
                  viewController: SearchViewControllable,
                  searchDetailBuilder: SearchDetailBuilder) {
        self.searchDetailBuilder = searchDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - Private
    private var searchDetailBuilder: SearchDetailBuilder
    
    // MARK: - SearchRouting
    func pushToSearchDetail(itunseModel: ItunseModel) {
        let searchDetail = searchDetailBuilder.build(withListener: interactor, itunseModel: itunseModel)
        attachChild(searchDetail)
        viewController.pushToSearchDetail(viewController: searchDetail.viewControllable)
    }
}
