//
//  PhoneNumber.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import Foundation

struct PhoneNumber {
    let countryCode: String
    let number: String
    
    var phoneNumber: String {
        countryCode + number
    }
}
