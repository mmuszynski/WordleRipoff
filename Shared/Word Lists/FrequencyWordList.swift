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
    
    private var frequencies: [String : Int] = [:]
    private var frequencyLimits: [Difficulty : Int] = [:]
    
    override init() {
        super.init()
        let url = Bundle.main.url(forResource: "frequencyList", withExtension: "csv")!
        let rawList = try! String(contentsOf: url)
        
        for line in rawList.components(separatedBy: .newlines) {
            let linePart = line.components(separatedBy: ",")
            let word = linePart[0].uppercased()
            
            guard word.count == 5 else { continue }
            
            words.append(word)
            frequencies[word] = Int(linePart[1])!
        }
        
        let values = Array(frequencies.values.sorted(by: >))
        let count = values.count
        let firstThird = count / 4
        let secondThird = 2 * firstThird
        
        frequencyLimits[.easy] = values[firstThird]
        frequencyLimits[.medium] = values[secondThird]
        
        self.words = frequencies.keys.map { $0.uppercased() }
    }
    
    override func getRandomWord() -> String {
        let word = self.words.randomElement()!
        let wordFrequency = self.frequencies[word]!
        
        switch self.difficulty {
        case .easy:
            if wordFrequency < frequencyLimits[.easy]! { return self.getRandomWord() }
        case .medium:
            if (frequencyLimits[.medium]!..<frequencyLimits[.easy]!).contains(wordFrequency) { return self.getRandomWord() }
        case .difficult:
            if wordFrequency > frequencyLimits[.medium]! { return self.getRandomWord() }
        }
        
        return word
    }
    
}
