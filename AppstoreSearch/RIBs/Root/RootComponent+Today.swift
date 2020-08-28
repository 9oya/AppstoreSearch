//
//  RootComponent+Today.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Today scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyToday: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the Today scope.
}

extension RootComponent: TodayDependency {

    // TODO: Implement properties to provide for Today scope.
}
