//
//  EnterOTPViewModel.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import Foundation
import RxSwift
import RxCocoa

class EnterOTPViewModel {
    
    struct Dependencies {
        // Properties
        let phoneNumber: PhoneNumber
        let otp: ControlProperty<String>
        // Events
        let didTapContinueButtton: ControlEvent<Void>
        let didTapEditPhoneButton: ControlEvent<Void>
        //Network
        let server: ServerType
    }
    
    //Events
    let showTabBarScreen: Observable<TabBarController.Dependencies>
    let isLoading: Driver<Bool>
    //State
    let errorState: Observable<Void>

    
    init(dependencies: Dependencies) {
        
        let load = Load { activity, errors in
            dependencies.didTapContinueButtton
                .withLatestFrom(dependencies.otp)
                .flatMap {
                    dependencies.server.otp(phoneNumber: dependencies.phoneNumber.phoneNumber, otp: $0)
                }
                .asSignalNeverError()
        }
        
        showTabBarScreen = load.finished.asObservable()
            .map { _ in
                TabBarController.Dependencies(
                    phoneNumber: dependencies.phoneNumber,
                    server: dependencies.server)
            }
        
        isLoading = load.isLoading.asDriver()
        
        errorState = load.error.mapToVoid().asObservable()
    }
}
