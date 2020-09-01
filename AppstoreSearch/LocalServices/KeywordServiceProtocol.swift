//
//  KeywordServiceProtocol.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

protocol KeywordServiceProtocol {
    func createKeyword(title: String, timeStamp: Date) -> Keyword?
    
    func getRecentKeywors() -> [Keyword]?
    
    func getKeywordByMatchingTitle(title: String) -> Keyword?
    
    func getKeywordsByContainTitle(title: String) -> [Keyword]?
    
    func updateKeywordScoreAndDateByMatchingTitle(title: String) -> Keyword?
}
