//
//  TodayInteractor.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift

protocol TodayRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TodayPresentable: Presentable {
    var listener: TodayPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol TodayListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class TodayInteractor: PresentableInteractor<TodayPresentable>, TodayInteractable, TodayPresentableListener {

    weak var router: TodayRouting?
    weak var listener: TodayListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TodayPresentable) {
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
