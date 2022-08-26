//
//  Rx+Extended.swift
//  DemoAisle
//
//  Created by Rakshith on 24/08/22.
//

import RxSwift
import RxCocoa


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
