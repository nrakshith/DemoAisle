//
//  Copy.swift
//  DemoAisle
//
//  Created by Rakshith on 29/08/22.
//

import UIKit

enum Copy {
    case getOTP
    case enterTheOTP
    case continueTitle
    case error
    case networkCallFailed
    case cancel
    case enterYourPhoneNumber
    case notes
    case personalMessagesToYou
    case taptoReviewNotes
    case interestedInYou
    case premiumMembersCanViewAllTheirLikesAtOnce
    case upgrade
    case discover
    case matches
    case profile

    
    var value: String {
        
        switch self {
        case .getOTP: return "Get OTP"
        case .enterTheOTP: return "Enter the \nOTP"
        case .continueTitle: return "Continue"
        case .error: return "Error"
        case .networkCallFailed: return "Network call failed"
        case .cancel: return "Cancel"
        case .enterYourPhoneNumber: return "Enter Your \nPhone Number"
        case .notes: return "Notes"
        case .personalMessagesToYou: return "Personal messages to you"
        case .taptoReviewNotes: return "Tap to review 50+ notes"
        case .interestedInYou: return "Interested In You"
        case .premiumMembersCanViewAllTheirLikesAtOnce: return "Premium members can view all their likes at once"
        case .upgrade: return "Upgrade"
        case .discover: return "Discover"
        case .matches: return "Matches"
        case .profile: return "Profile"
        }
    }
}
