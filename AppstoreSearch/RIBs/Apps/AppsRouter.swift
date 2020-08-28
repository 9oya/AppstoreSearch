//
//  AppsRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol AppsInteractable: Interactable {
    var router: AppsRouting? { get set }
    var listener: AppsListener? { get set }
}

protocol AppsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AppsRouter: ViewableRouter<AppsInteractable, AppsViewControllable>, AppsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AppsInteractable, viewController: AppsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
