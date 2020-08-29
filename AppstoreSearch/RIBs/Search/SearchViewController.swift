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
    func searchAppsWithKeyword(keyword: String?)
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {
    
    // MARK: - Properties
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Actions
    
    // MARK: - SearchPresentable
    weak var listener: SearchPresentableListener?
    
    func reloadTableView() {
        searchTableView.reloadData()
    }
    
    func beginUpdateTableView() {
        searchTableView.beginUpdates()
    }
    
    func endUpdateTableView() {
        searchTableView.endUpdates()
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recentKeyTableCellId, for: indexPath) as! RecentKeyTableViewCell
        cell.titleLabel.text = "Hello"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let txt = searchController.searchBar.text!
        listener?.searchAppsWithKeyword(keyword: txt)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
    }
}

extension SearchViewController {
    private func setupLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}
