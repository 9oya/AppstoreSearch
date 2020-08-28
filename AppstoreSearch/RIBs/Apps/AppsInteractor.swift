//
//  AppsInteractor.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift

protocol AppsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AppsPresentable: Presentable {
    var listener: AppsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AppsListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppsInteractor: PresentableInteractor<AppsPresentable>, AppsInteractable, AppsPresentableListener {

    weak var router: AppsRouting?
    weak var listener: AppsListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AppsPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
