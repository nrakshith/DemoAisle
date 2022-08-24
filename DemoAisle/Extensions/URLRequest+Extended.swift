//
//  URLRequest+Extended.swift
//  DemoAisle
//
//  Created by Rakshith on 25/08/22.
//

import UIKit

extension URLRequest {
    
    init<T: Encodable>(method: HTTPMethod, idToken: String? = nil, baseURL: String = AppConfiguration.baseURL, path: String = "", percentEncodePlus: Bool = false, json: T) {

        var components = URLComponents(string: baseURL)!
        components.path += path

        if percentEncodePlus {
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }

        self.init(url: components.url!, timeoutInterval: 20)
        
        if let idToken = idToken {
            addValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        }
        
        httpMethod = method.rawValue
        
        if json is EmptyRequest == false {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.dateEncodingStrategy = .isoO8601withFractionalSeconds
            httpBody = try! jsonEncoder.encode(json)
        }
        
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Add device headers
        addValue("iOS", forHTTPHeaderField: "x-device-os")
        addValue(UIDevice.current.systemVersion, forHTTPHeaderField: "x-device-os-version")
    }
    
    
    
    enum HTTPMethod: String {
        case POST
        case GET
        case PUT
        case DELETE
    }
    
}
