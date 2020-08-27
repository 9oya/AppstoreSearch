//
//  RootRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, SearchListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         searchBuilder: SearchBuildable) {
        
        self.searchBuilder = searchBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routeToSearch()
    }
    
    // MARK: - Private
    
    private let searchBuilder: SearchBuildable
    
    private var search: ViewableRouting?
    
    private  func routeToSearch() {
        let search = searchBuilder.build(withListener: interactor)
        self.search = search
        attachChild(search)
        viewController.replaceModal(viewController: search.viewControllable)
    }
}
