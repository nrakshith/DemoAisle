//
//  Server.swift
//  DemoAisle
//
//  Created by Rakshith on 24/08/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol ServerType {
    func login(phoneNumber: PhoneNumber) -> Observable<PhoneNumberLoginModel>
    func otp(phoneNumber: String, otp: String) -> Observable<OTPLoginModel>
}

struct Server: ServerType {
    
    private let session: URLSession
    private let disposeBag = DisposeBag()
    
    init(session: URLSession = .default) {
        self.session = session
    }
    
    func login(phoneNumber: PhoneNumber) -> Observable<PhoneNumberLoginModel> {
        
        let request = URLRequest(
            method: .POST,
            path: "/users/phone_number_login",
            json: [
                "number" : phoneNumber.phoneNumber
            ]
        )
        
        let observable: Observable<PhoneNumberLoginModel> = session.observable(for: request)
        
        return observable
            .checkForErrors
    }
    
    func otp(phoneNumber: String, otp: String) -> Observable<OTPLoginModel> {
        
        let request = URLRequest(
            method: .POST,
            path: "/users/verify_otp",
            json: [
                "number" : phoneNumber,
                "otp" : otp
            ]
        )
        let observable: Observable<OTPLoginModel> = session.observable(for: request)

        return observable
            .checkForErrors

    }
}
