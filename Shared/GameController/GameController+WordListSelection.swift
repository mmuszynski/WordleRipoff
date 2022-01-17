//
//  GameController+WordList.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

extension GameController {
    enum WordListSelection: CaseIterable, CustomStringConvertible {
        case unix
        case frequency
        case nswl
        case washu
        case wordle
        
        var wordListInitializer: (_ wordLength: Int)->WordList {
            switch self {
            case .unix:
                return { UnixWordList(wordLength: $0) }
            case .frequency:
                return { FrequencyWordList(wordLength: $0) }
            case .nswl:
                return { NSWLWordList(wordLength: $0) }
            case .washu:
                return { WashUnivWordList(wordLength: $0) }
            case .wordle:
                return { _ in OGWordList(wordLength: 5) }
            }
        }
        
        var description: String {
            switch self {
            case .unix:
                return "Unix"
            case .frequency:
                return "Sample Frequency"
            case .nswl:
                return "Scrabble"
            case .washu:
                return "WashU"
            case .wordle:
                return "Original Wordle"
            }
        }
    }
}
