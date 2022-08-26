//
//  AppDelegateDependencies.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import Foundation

struct AppDelegateDependencies {

    let server: ServerType

    init() {
        self.server = Server()
    }
}
