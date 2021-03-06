//
//  SearchViewController.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SearchPresentableListener: class {
    func getCurrTableCellType() -> SearchTableCellType
    
    func getRecentKeywords()
    
    func getAutoComplKeywords(title: String)
    
    func searchAppsWithTerm(title: String?)
    
    func numberOfSections() -> Int
    
    func numberOfRecentKeywords() -> Int
    
    func numberOfAutoComplKeywords() -> Int
    
    func numberOfSearchResult() -> Int
    
    func recentKeywordAt(indexPath: IndexPath) -> Keyword?
    
    func autoComplKeywordAt(indexPath: IndexPath) -> Keyword?
    
    func itunseModelAt(indexPath: IndexPath) -> ItunseModel?
    
    func configureRecentKeyTableCell(cell: RecentKeyTableViewCell, indexPath: IndexPath)
    
    func configureAutoComplTableCell(cell: AutoComplTableViewCell, indexPath: IndexPath, title: String)
    
    func configureSearchTableCell(cell: SearchResultTableViewCell, indexPath: IndexPath)
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {
    
    // MARK: - Properties
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchController: UISearchController!
    
    var isOnLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        listener?.getRecentKeywords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - SearchPresentable
    weak var listener: SearchPresentableListener?
    
    func reloadTableView() {
        view.hideSpinner()
        UIView.transition(with: searchTableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.searchTableView.isHidden = false
            self.searchTableView.reloadData()
        })
    }
    
    func beginUpdateTableView() {
        searchTableView.beginUpdates()
    }
    
    func endUpdateTableView() {
        searchTableView.endUpdates()
    }
    
    // MARK: - SearchViewControllable
    func pushToSearchDetail(viewController: ViewControllable?) {
        if let targetVC = viewController {
            targetVC.uiviewController.navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.pushViewController(targetVC.uiviewController, animated: true)
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: recentKeyTableViewHeaderId) as! RecentKeyTableViewHeader
        view.titleLabel.text = "최근 검색어"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch listener!.getCurrTableCellType() {
        case .recentKey:
            return listener?.numberOfRecentKeywords() ?? 0
        case .autoCompl:
            return listener?.numberOfAutoComplKeywords() ?? 0
        case .searchResult:
            return listener?.numberOfSearchResult() ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch listener!.getCurrTableCellType() {
        case .recentKey:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: recentKeyTableCellId, for: indexPath) as? RecentKeyTableViewCell else {
                fatalError()
            }
            listener?.configureRecentKeyTableCell(cell: cell, indexPath: indexPath)
            return cell
        case .autoCompl:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: autoComplTableCellId, for: indexPath) as? AutoComplTableViewCell else {
                fatalError()
            }
            listener?.configureAutoComplTableCell(cell: cell, indexPath: indexPath, title: searchController.searchBar.text!)
            return cell
        case .searchResult:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: searchResultTableCellId, for: indexPath) as? SearchResultTableViewCell else {
                fatalError()
            }
            listener?.configureSearchTableCell(cell: cell, indexPath: indexPath)
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch listener!.getCurrTableCellType() {
        case .recentKey:
            view.showSpinner()
            isOnLoading = true
            let txt = listener?.recentKeywordAt(indexPath: indexPath)?.title
            UIView.transition(with: searchTableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.searchTableView.isHidden = true
                self.searchController.searchBar.text = txt
                self.searchController.isActive = true
            }) { _ in
                self.isOnLoading = false
                self.listener?.searchAppsWithTerm(title: txt)
            }
        case .autoCompl:
            searchController.searchBar.endEditing(true)
            view.showSpinner()
            listener?.searchAppsWithTerm(title: listener?.autoComplKeywordAt(indexPath: indexPath)?.title)
        case .searchResult:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch listener!.getCurrTableCellType() {
        case .recentKey:
            return 70
        case .autoCompl:
            return 0
        case .searchResult:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch listener!.getCurrTableCellType() {
        case .recentKey:
            return 44
        case .autoCompl:
            return 44
        case .searchResult:
            return 295
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive && !isOnLoading {
            let txt = searchController.searchBar.text!
            listener?.getAutoComplKeywords(title: txt)
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        listener?.getRecentKeywords()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.showSpinner()
        let txt = searchBar.text!
        listener?.searchAppsWithTerm(title: txt)
    }
}

extension SearchViewController {
    
    // MARK: - Private
    private func setupLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barTintColor = .systemBackground
        
        searchController = {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            
            searchController.searchBar.placeholder = "App Store"
            
            return searchController
        }()
        navigationItem.searchController = searchController
        
        searchTableView.register(RecentKeyTableViewHeader.self, forHeaderFooterViewReuseIdentifier: recentKeyTableViewHeaderId)
        searchTableView.register(UINib(nibName: recentKeyTableCellId, bundle: nil), forCellReuseIdentifier: recentKeyTableCellId)
        searchTableView.register(UINib(nibName: autoComplTableCellId, bundle: nil), forCellReuseIdentifier: autoComplTableCellId)
        searchTableView.register(UINib(nibName: searchResultTableCellId, bundle: nil), forCellReuseIdentifier: searchResultTableCellId)
        
        searchController.searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}
