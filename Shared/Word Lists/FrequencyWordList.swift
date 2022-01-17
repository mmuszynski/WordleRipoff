//
//  FrequencyWordList.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

class FrequencyWordList: WordList {
    
    enum Difficulty {
        case easy, medium, difficult
    }
    
    var difficulty: Difficulty = .easy
    
    override init(wordLength: Int? = nil) {
        super.init()
        let url = Bundle.main.url(forResource: "frequencyList", withExtension: "csv")!
        let rawList = try! String(contentsOf: url)
        
        for line in rawList.components(separatedBy: .newlines) {
            let linePart = line.components(separatedBy: ",")
            let word = linePart[0].uppercased()
            
            guard word.count == wordLength ?? 5 else { continue }
            
            words.append(word)
        }
    }
    
    override func getRandomWord() -> String {
        var range = 0..<1000
        
        switch self.difficulty {
        case .difficult:
            range = 0..<words.endIndex
        case .medium:
            range = 0..<10000
        default:
            break
        }
        
        return self.words[range].randomElement()!
    }
    
}
