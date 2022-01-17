//
//  GameController+Clue.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation
import SwiftUI

extension GameController {
    enum Clue: CaseIterable {
        case unchecked
        case notPresent
        case present
        case correct
        
        var color: Color {
            switch self {
            case .unchecked:
                return .uncheckedClueColor
            case .notPresent:
                return .notPresentClueColor
            case .present:
                return .presentClueColor
            case .correct:
                return .correctClueColor
            }
        }
    }
}
