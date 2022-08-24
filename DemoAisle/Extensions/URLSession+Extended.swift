//
//  URLSession+Extended.swift
//  DemoAisle
//
//  Created by Rakshith on 25/08/22.
//

import Foundation
import RxSwift
import RxCocoa

extension URLSession {
    
    static var `default`: URLSession {
        return URLSession(configuration: .default)
    }

    func observable<T: Decodable>(for request: URLRequest) -> Observable<T> {
        return Observable.create { [unowned self] observer in
                        
            let task = self.dataTask(with: request) { data, response, error in
                
                guard let data = data else {
                    return observer.onError(ConnectionError(error: error! as NSError))
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .isoO8601withFractionalSeconds
                
                do {
                    let object = try decoder.decode(T.self, from: data, allowEmptyResponse: true)
                    observer.onNext(object)
                    return observer.onCompleted()
                } catch {
                    return observer.onError(ConnectionError(error: error as NSError))
                }
            }

            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
            .switchToMainThread()
            .catch { .error($0.transformClientSideErrors()) }
        
    }
}
