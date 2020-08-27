//
//  RootComponent+Search.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Search scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencySearch: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the Search scope.
}

extension RootComponent: SearchDependency {
    
}
