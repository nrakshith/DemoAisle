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
}
