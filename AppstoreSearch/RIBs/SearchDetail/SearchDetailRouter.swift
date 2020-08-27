//
//  SearchDetailRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol SearchDetailInteractable: Interactable {
    var router: SearchDetailRouting? { get set }
    var listener: SearchDetailListener? { get set }
}

protocol SearchDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchDetailRouter: ViewableRouter<SearchDetailInteractable, SearchDetailViewControllable>, SearchDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchDetailInteractable, viewController: SearchDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
