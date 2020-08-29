//
//  SearchInteractor.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    
    func reloadTableView()
    
    func beginUpdateTableView()
    
    func endUpdateTableView()
}

protocol SearchListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable, SearchPresentableListener {

    weak var router: SearchRouting?
    weak var listener: SearchListener?

    override init(presenter: SearchPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: - Life cycle
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - Private
    private var ituneseWrapperModel: ItunseWrapperModel?
    
    private func itunseModelAt(indexPath: IndexPath) -> ItunseModel? {
        if let wrapperModel = ituneseWrapperModel, let itunseModels = wrapperModel.results {
            return itunseModels[indexPath.row]
        } else {
            return nil
        }
    }
    
    // MARK: - SearchPresentableListener
    func getRecentKeywords() {
        
    }
    
    func searchAppsWithKeyword(keyword: String?) {
        SearchService.shared.getAppsByTitle(title: keyword!) { (result) in
            self.ituneseWrapperModel = result
            self.presenter.reloadTableView()
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        if let wrapperModel = ituneseWrapperModel {
            return wrapperModel.resultCount
        } else {
            return 0
        }
    }
    
    // TODO
//    func configureSearchTableCell(cell: , indexPath: IndexPath) {
//        let itunseModel = itunseModelAt(indexPath: indexPath)
//
//    }
}
