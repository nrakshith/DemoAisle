//
//  OTPLoginModel.swift
//  DemoAisle
//
//  Created by Rakshith on 28/08/22.
//

import Foundation

protocol OTPLoginResponseType: Decodable {
    var token: String? { get }
}

struct OTPLoginModel: Decodable, OTPLoginResponseType {
    
    let token: String?
}
