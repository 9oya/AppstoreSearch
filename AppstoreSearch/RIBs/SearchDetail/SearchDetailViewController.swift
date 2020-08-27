//
//  SearchDetailViewController.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SearchDetailPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchDetailViewController: UIViewController, SearchDetailPresentable, SearchDetailViewControllable {

    weak var listener: SearchDetailPresentableListener?
}
