//
//  SearchDetailInteractor.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDetailPresentable: Presentable {
    var listener: SearchDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchDetailInteractor: PresentableInteractor<SearchDetailPresentable>, SearchDetailInteractable, SearchDetailPresentableListener {
    
    weak var router: SearchDetailRouting?
    weak var listener: SearchDetailListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchDetailPresentable,
         itunseModel: ItunseModel) {
        self.itunseModel = itunseModel
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
    
    // MARK: - Private
    private var itunseModel: ItunseModel
}
