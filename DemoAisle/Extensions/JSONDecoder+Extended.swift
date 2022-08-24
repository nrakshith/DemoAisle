//
//  JSONDecoder+Extended.swift
//  DemoAisle
//
//  Created by Rakshith on 25/08/22.
//

import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data, allowEmptyResponse: Bool = false) throws -> T where T : Decodable {
        if allowEmptyResponse && type is EmptyResponse.Type && data.count == 0 {
            return EmptyResponse() as! T
        } else {
            return try decode(type, from: data)
        }
    }
}

extension JSONDecoder.DateDecodingStrategy {
    
    /// https://stackoverflow.com/a/46538676
    static var isoO8601withFractionalSeconds: JSONDecoder.DateDecodingStrategy {
        return JSONDecoder.DateDecodingStrategy.custom { decoder -> Date in

            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            throw NSError(localizedDescription: "Problem parsing date")
        }
    }
}

extension JSONEncoder.DateEncodingStrategy {
    
    static var isoO8601withFractionalSeconds: JSONEncoder.DateEncodingStrategy {
        return JSONEncoder.DateEncodingStrategy.custom { date, encoder in
            var container = encoder.singleValueContainer()
            let string = date.formatter.ISO8601
            try container.encode(string)
        }
    }
}

