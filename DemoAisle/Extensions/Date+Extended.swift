//
//  Date+Extended.swift
//  DemoAisle
//
//  Created by Rakshith on 25/08/22.
//

import Foundation

// Formatter
extension Date {
    
    struct Formatter {
        let date: Date
        
        private enum Format: String {
            case SSS = "SSS"
            case ddMMyyy = "dd/MM/yyyy"
            case dMMMMyyyy = "d MMMM yyyy"
            case MMMMyyyy = "MMMM yyyy"
            case dd = "dd"
            case MMM = "MMM"
        }
        
        var milliseconds: String {
            return date(with: .SSS)
        }
        
        /// Returns in format of "2018-01-17T00:05:00.000Z"
        var ISO8601: String {
            let zulu = "Z"
            let formatter = ISO8601DateFormatter()
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            var string: String
            // Even though `.withFractionalSeconds` is available from 11.0, it crashes unless device is 11.2, http://www.openradar.me/35660658
            if #available(iOS 11.2, *) {
                formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone, .withFullTime, .withFractionalSeconds]
                string = formatter.string(from: date)
            } else { // iOS 10.X shows "2018-01-17T05:11:20Z", need to add milliseconds i.e. ".000Z"
                formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone, .withFullTime]
                let milliseconds = ".\(date.formatter.milliseconds)\(zulu)"
                string = formatter.string(from: date).replacingOccurrences(of: zulu, with: milliseconds)
            }
            return string
        }
        
        /// i.e. 25/01/2018
        var shortDate: String {
            return date(with: .ddMMyyy)
        }
        
        /// i.e. 25 January 2018
        var longDate: String {
            return date(with: .dMMMMyyyy)
        }
        
        /// i.e. 1:05pm
        var shortTime: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mma"
            formatter.amSymbol = "am"
            formatter.pmSymbol = "pm"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter.string(from: date)
        }
        
        var longDateNoDate: String {
            return date(with: .MMMMyyyy)
        }
        
        var day: String {
            return date(with: .dd)
        }
        
        var month: String {
            return date(with: .MMM)
        }
        
        private func date(with format: Format) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format.rawValue
            return formatter.string(from: date)
        }
    }
    
    var formatter: Formatter {
        return Formatter(date: self)
    }
}

extension Date {
    
    /// Format of `d/M/yyyy h:mm:ssa` i.e. `02/02/2018 10:33:01am`
    init?(string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy h:mm:ssa"
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval: 0, since: date)
    }
    
    var truncatedSeconds: Date {
        let timeInterval = floor(self.timeIntervalSinceReferenceDate / 60) * 60
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    func truncatedToMonth() -> Date? {
        let calendar =  Calendar.current
        let components = calendar.dateComponents([.era, .year, .month], from: self)
        let truncatedDate = calendar.date(from: components)
        return truncatedDate
    }
    
    /// Returns true if the receiver is 8 seconds earlier than `endDate`
    func is8SecondsPrior(to endDate: Date) -> Bool {
        let startDate = self
        let components = Calendar.current.dateComponents([.second], from: startDate, to: endDate)
        return components.second! > 8
    }
    
    /// Adds seconds to date. Rounds `seconds` to Int, so precision is lost.
    func adding(seconds: TimeInterval) -> Date {
        let seconds = Int(seconds)
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }
    
    // https://stackoverflow.com/a/40057117/4698501
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
    
    static func adding(_ value: Int, to component: Calendar.Component) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: Date())
    }
}









