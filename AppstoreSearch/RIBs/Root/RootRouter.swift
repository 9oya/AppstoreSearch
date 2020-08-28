//
//  RootRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, UpdateListener, SearchListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func setupViewControllers(viewControllers: [ViewControllable])
    
    func replaceModal(viewController: ViewControllable?)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         searchBuilder: SearchBuildable,
         updateBuilder: UpdateBuildable) {
        
        self.updateBuilder = updateBuilder
        self.searchBuilder = searchBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
//        routeToSearch()
        setupViewControllers()
    }
    
    // MARK: - Private
    
    private let updateBuilder: UpdateBuildable
    private let searchBuilder: SearchBuildable
    
    private var update: ViewableRouting?
    private var search: ViewableRouting?
    
    private func setupViewControllers() {
        let search = searchBuilder.build(withListener: interactor)
        self.search = search
        
        let update = updateBuilder.build(withListener: interactor)
        self.update = update
        
        viewController.setupViewControllers(viewControllers: [update.viewControllable, search.viewControllable])
    }
    
    private func routeToSearch() {
        let search = searchBuilder.build(withListener: interactor)
        self.search = search
        attachChild(search)
        viewController.replaceModal(viewController: search.viewControllable)
    }
}
