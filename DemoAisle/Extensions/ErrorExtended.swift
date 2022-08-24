//
//  ErrorExtended.swift
//  DemoAisle
//
//  Created by Rakshith on 25/08/22.
//

import Foundation

extension Error {

    func transformClientSideErrors() -> Error {
        guard let urlError = self as? URLError else {
            return self
        }
        
        switch urlError.code {
        case .notConnectedToInternet:   return NSError(localizedDescription: "Not connected to the internet")
        case .timedOut:                 return NSError(localizedDescription: "The request timed out")
        default:                        return self
        }
    }
}

extension NSError {
    convenience init(localizedDescription: String) {
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
        self.init(domain: "", code: 0, userInfo: userInfo)
    }
}
