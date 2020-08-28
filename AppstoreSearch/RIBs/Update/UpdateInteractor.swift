//
//  UpdateInteractor.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift

protocol UpdateRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol UpdatePresentable: Presentable {
    var listener: UpdatePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol UpdateListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class UpdateInteractor: PresentableInteractor<UpdatePresentable>, UpdateInteractable, UpdatePresentableListener {

    weak var router: UpdateRouting?
    weak var listener: UpdateListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: UpdatePresentable) {
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
