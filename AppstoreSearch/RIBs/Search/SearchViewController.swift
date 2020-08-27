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

    weak var listener: SearchPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
