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
    func searchKeyword(keyword: String?)
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchController: UISearchController!

    weak var listener: SearchPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: searchTableViewHeaderId) as! SearchTableViewHeader
        view.titleLabel.text = "최근 검색어"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchTableCellId, for: indexPath) as! SearchTableViewCell
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
        print(searchController.searchBar.text!)
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
        
        searchTableView.register(SearchTableViewHeader.self, forHeaderFooterViewReuseIdentifier: searchTableViewHeaderId)
        searchTableView.register(UINib(nibName: searchTableCellId, bundle: nil), forCellReuseIdentifier: searchTableCellId)
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}
