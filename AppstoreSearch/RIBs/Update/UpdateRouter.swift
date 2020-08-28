//
//  UpdateRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol UpdateInteractable: Interactable {
    var router: UpdateRouting? { get set }
    var listener: UpdateListener? { get set }
}

protocol UpdateViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class UpdateRouter: ViewableRouter<UpdateInteractable, UpdateViewControllable>, UpdateRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: UpdateInteractable, viewController: UpdateViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
