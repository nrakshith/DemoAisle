//
//  Errors.swift
//  DemoAisle
//
//  Created by Rakshith on 25/08/22.
//

import Foundation

struct ConnectionError: Error {
    
    enum ConnectionErrorType: Int{
        case networkConnectionLost = 1001
        case notConnectedToInternet = 1002
        case timedOut = 1003
        case others = 1000
    }
    
    let error: NSError
}
