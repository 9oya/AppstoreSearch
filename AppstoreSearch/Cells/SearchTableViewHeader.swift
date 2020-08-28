//
//  SearchTableViewHeader.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

let searchTableViewHeaderId = "SearchTableViewHeader"

class SearchTableViewHeader: UITableViewHeaderFooterView {

    // MARK: - Properties
    
    var titleLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTableViewHeader {
    func configureContents() {
        contentView.backgroundColor = .systemBackground
        
        titleLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 25, weight: .bold)
            label.textColor = .label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
}
