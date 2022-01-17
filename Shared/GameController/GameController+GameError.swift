//
//  GameController+GameError.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

extension GameController {
    enum GameError: Error, CustomStringConvertible {
        case notInList(_ word: String)
        case notEnoughLetters
        case victory
        case failure(_ word: String)
        case debug(word: String)
        
        var allowsContinuation: Bool {
            switch self {
            case .victory, .failure(_):
                return false
            default:
                return true
            }
        }
        
        var description: String {
            switch self {
            case .notEnoughLetters:
                return "Not enough letters"
            case .notInList(let word):
                return "\(word)\r is not a recognized word"
            case .victory:
                return "Correct!"
            case .failure(let word):
                return "The correct word was \r\(word)"
            case .debug(let word):
                return "The correct word is \r\(word)"
            }
        }
        
    }
    
}
