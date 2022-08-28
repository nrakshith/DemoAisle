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
    let showPhoneNumberScreen: Signal<Void>
    let updateCounter =  PublishRelay<String>()

    //State
    let errorState: Observable<Void>
    
    private let disposeBag = DisposeBag()
    
    init(dependencies: Dependencies) {
        
        let load = Load { activity, errors in
            dependencies.didTapContinueButtton
                .withLatestFrom(dependencies.otp)
                .flatMap {
                    dependencies.server.otp(phoneNumber: dependencies.phoneNumber.phoneNumber, otp: $0).activity(activity, errors: errors)
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
        
        showPhoneNumberScreen = dependencies.didTapEditPhoneButton.asSignal()

        
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
                .take(60)
                .subscribe(onNext: { timePassed in
                    let count = 60 - timePassed
                    let minutes = (count % 3600) / 60
                    let seconds = (count % 3600) % 60
                    self.updateCounter.accept("\(minutes):\(seconds)")
                }).disposed(by: disposeBag)
    }
}
