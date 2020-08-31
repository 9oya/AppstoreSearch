//
//  SearchComponent+SearchDetail.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Search to provide for the SearchDetail scope.
// TODO: Update SearchDependency protocol to inherit this protocol.
protocol SearchDependencySearchDetail: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Search to provide dependencies
    // for the SearchDetail scope.
}

extension SearchComponent: SearchDetailDependency {
    // TODO: Implement properties to provide for SearchDetail scope.
}
