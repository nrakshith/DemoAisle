//
//  PhoneNumberLoginModel.swift
//  DemoAisle
//
//  Created by Rakshith on 28/08/22.
//

import Foundation

protocol PhoneResponseType: Decodable {
    var status: Bool? { get }
}

struct PhoneNumberLoginModel: Decodable, PhoneResponseType {    
    
    var status: Bool?
}

