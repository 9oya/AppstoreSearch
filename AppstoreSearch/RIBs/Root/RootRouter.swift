//
//  RootRouter.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, TodayListener, GameListener, AppsListener, UpdateListener, SearchListener {
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
         todayBuilder: TodayBuildable,
         gameBuilder: GameBuildable,
         appsBuilder: AppsBuildable,
         updateBuilder: UpdateBuildable,
         searchBuilder: SearchBuildable) {
        
        self.todayBuilder = todayBuilder
        self.gameBuilder = gameBuilder
        self.appsBuilder = appsBuilder
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
    
    private let todayBuilder: TodayBuildable
    private let gameBuilder: GameBuildable
    private let appsBuilder: AppsBuildable
    private let updateBuilder: UpdateBuildable
    private let searchBuilder: SearchBuildable
    
    private var today: ViewableRouting?
    private var game: ViewableRouting?
    private var apps: ViewableRouting?
    private var update: ViewableRouting?
    private var search: ViewableRouting?
    
    private func setupViewControllers() {
        let today = todayBuilder.build(withListener: interactor)
        today.viewControllable.uiviewController.title = "투데이"
        today.viewControllable.uiviewController.tabBarItem.image = {
            let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
            return UIImage(systemName: "calendar", withConfiguration: config)
        }()
        self.today = today
        
        let game = gameBuilder.build(withListener: interactor)
        game.viewControllable.uiviewController.title = "게임"
        game.viewControllable.uiviewController.tabBarItem.image = {
            let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
            return UIImage(systemName: "gamecontroller.fill", withConfiguration: config)
        }()
        self.game = game
        
        let apps = appsBuilder.build(withListener: interactor)
        apps.viewControllable.uiviewController.title = "앱"
        apps.viewControllable.uiviewController.tabBarItem.image = {
            let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
            return UIImage(systemName: "square.stack.3d.up.fill", withConfiguration: config)
        }()
        self.apps = apps
        
        let update = updateBuilder.build(withListener: interactor)
        update.viewControllable.uiviewController.title = "업데이트"
        update.viewControllable.uiviewController.tabBarItem.image = {
            let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
            return UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: config)
        }()
        self.update = update
        
        let search = searchBuilder.build(withListener: interactor)
        search.viewControllable.uiviewController.title = "검색"
        search.viewControllable.uiviewController.tabBarItem.image = {
            let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .medium, scale: .large)
            return UIImage(systemName: "magnifyingglass", withConfiguration: config)
        }()
        self.search = search
        
        viewController.setupViewControllers(viewControllers: [today.viewControllable, game.viewControllable, apps.viewControllable, update.viewControllable, search.viewControllable])
    }
    
    private func routeToSearch() {
        let search = searchBuilder.build(withListener: interactor)
        self.search = search
        attachChild(search)
        viewController.replaceModal(viewController: search.viewControllable)
    }
}
