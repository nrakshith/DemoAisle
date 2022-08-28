//
//  Rx+Extended.swift
//  DemoAisle
//
//  Created by Rakshith on 24/08/22.
//

import RxSwift
import RxCocoa
import Foundation


extension ObservableConvertibleType {
    
    func mapToVoid() -> Observable<Void> {
        return asObservable().map { _ in
            return
        }
    }
}

extension ObservableType {
    func switchToMainThread() -> Observable<Element> {
        return observe(on: MainScheduler.instance)
    }
    
    func asDriverNeverError() -> Driver<Element> {
        return asDriver { _ in
            return .never()
        }
    }
}

extension ObservableConvertibleType {
    func asSignalNeverError() -> RxCocoa.Signal<Self.Element> {
        return asSignal(onErrorSignalWith: .never())
    }
}

extension Driver where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    func driveNext(_ onNext: ((Self.Element) -> Void)? = nil) -> RxSwift.Disposable {
        return drive(onNext: onNext)
    }
}

extension PublishRelay {
    func asControlEvent() -> ControlEvent<Element> {
        ControlEvent(events: self)
    }
}

extension Observable where Element: PhoneResponseType {
    var checkForErrors: Observable<Element> {
        asObservable()
            .map { response in
                if response.status == true {
                    return response
                } else {
                    throw NSError(localizedDescription: "Wrong password")
                }
            }
    }
}

extension Observable where Element: OTPLoginResponseType {
    var checkForErrors: Observable<Element> {
        asObservable()
            .map { response in
                if let  token = response.token, !token.isEmpty {
                    return response
                } else {
                    throw NSError(localizedDescription: "Wrong password")
                }
            }
    }
            
}

extension Observable {
    func activity(_ activity: ActivityIndicator, errors: PublishSubject<Error>) -> Observable {
        return track(activity).errors(errors)
    }
    
    func errors(_ errors: PublishSubject<Error>) -> Observable {
        return asObservable().do(onError: errors.onNext).ignoreErrors()
    }
    
    func ignoreErrors() -> Observable {
        return catchError { _ in Observable.never() }
    }
}

extension ObservableConvertibleType {
    fileprivate func track(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.SignalSharingStrategy {
    func emitNext(_ onNext: @escaping ((Self.Element) -> Void)) -> RxSwift.Disposable {
        return emit(onNext: onNext)
    }
}
