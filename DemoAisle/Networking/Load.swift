//
//  Load.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import Foundation
import RxSwift
import RxCocoa

struct Load<Object> {
    let finished: Signal<Object>
    let isLoading: Driver<Bool>
    let error: PublishSubject<Error>
    
    /// Providing an `ActivityIndicator` allows a single `ActivityIndicator` to be shared between multiple Load operations
    init(activityIndicator: ActivityIndicator = ActivityIndicator(), errorRelay: PublishSubject<Error> = PublishSubject<Error>(), _ closure: ((ActivityIndicator, PublishSubject<Error>) -> Signal<Object>)) {
        self.error = errorRelay
        self.isLoading = activityIndicator.asDriver()
        finished = closure(activityIndicator, errorRelay)
    }
}
