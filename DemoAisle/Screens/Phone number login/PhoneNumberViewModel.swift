//
//  PhoneNumberViewModel.swift
//  DemoAisle
//
//  Created by Rakshith on 26/08/22.
//

import Foundation
import RxSwift
import RxCocoa

class PhoneNumberViewModel {
    
    struct Dependencies {
        // Properties
        let countryCode: ControlProperty<String>
        let phoneNumber: ControlProperty<String>
        // Events
        let didTapContinueButtton: ControlEvent<Void>
        //Network
        let server: ServerType
    }
    
    //Events
    let showOTPScreen: Observable<EnterOTPViewController.Dependencies>
    let isLoading: Driver<Bool>
    //State
    let errorState: Observable<Void>

    
    init(dependencies: Dependencies) {
        
        let phoneNumber = ControlProperty.combineLatest(
            dependencies.countryCode,
            dependencies.phoneNumber
        )
        .map { PhoneNumber(countryCode: .init($0.0), number: .init($0.1)) }
        .asDriverNeverError()
        
        let load = Load { activity, errors in
            dependencies.didTapContinueButtton
                .withLatestFrom(phoneNumber)
                .flatMap {
                    dependencies.server.login(phoneNumber: $0).activity(activity, errors: errors)
                }
                .asSignalNeverError()
        }
        
        showOTPScreen = load.finished.asObservable()
            .withLatestFrom(phoneNumber)
            .map { phoneNumber in
                EnterOTPViewController.Dependencies(
                phoneNumber: phoneNumber,
                server: dependencies.server)
            }
        
        isLoading = load.isLoading.asDriver()
        
        errorState = load.error.mapToVoid().asObservable()
    }
}
