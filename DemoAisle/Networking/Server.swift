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
    func login(phoneNumber: PhoneNumber) -> Observable<Void>
    func otp(phoneNumber: String, otp: String) -> Observable<Void>
}

struct Server: ServerType {
    private let session: URLSession
    
    init(session: URLSession = .default) {
        self.session = session
    }
    
    func login(phoneNumber: PhoneNumber) -> Observable<Void> {
        
        let request = URLRequest(
            method: .POST,
            path: "/users/phone_number_login",
            json: [
                "number" : phoneNumber.phoneNumber
            ]
        )
        
        let observable: Observable<EmptyResponse> = session.observable(for: request)
        
        return observable.mapToVoid()
    }
    
    func otp(phoneNumber: String, otp: String) -> Observable<Void> {
        struct Response: Decodable {
            let authToken: String
        }
        let request = URLRequest(
            method: .POST,
            path: "/users/verify_otp",
            json: [
                "number" : phoneNumber,
                "otp" : otp
            ]
        )
        let observable: Observable<Response> = session.observable(for: request)
        
        return observable.mapToVoid()
    }
}
