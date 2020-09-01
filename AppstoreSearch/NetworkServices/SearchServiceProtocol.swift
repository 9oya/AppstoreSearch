//
//  SearchServiceProtocol.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

protocol SearchServiceProtocol {
    func getAppsByTitle(title: String, completion: @escaping (_ result: ItunseWrapperModel) -> Void)
}
