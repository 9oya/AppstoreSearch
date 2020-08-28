//
//  GameRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol GameInteractable: Interactable {
    var router: GameRouting? { get set }
    var listener: GameListener? { get set }
}

protocol GameViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class GameRouter: ViewableRouter<GameInteractable, GameViewControllable>, GameRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: GameInteractable, viewController: GameViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
