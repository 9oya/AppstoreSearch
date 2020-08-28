//
//  RootComponent+Update.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Update scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyUpdate: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the Update scope.
}

extension RootComponent: UpdateDependency {

    // TODO: Implement properties to provide for Update scope.
}
