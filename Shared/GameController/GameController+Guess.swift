//
//  GameController+Guess.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

extension GameController {
    struct Guess {
        var length: Int
        var word = ""
        var clues: Array<Clue>
        
        init(word: String, clues: Array<Clue>, length: Int? = nil) {
            self.word = word
            self.clues = clues
            self.length = length ?? 5
        }
        
        init(length: Int? = nil) {
            self.length = length ?? 5
            self.clues = Array<Clue>(repeating: .unchecked, count: length ?? 5)
        }
        
        mutating func respond(to character: Character) {
            let character = character.uppercased()
            guard word.count < self.length else { return }
            guard clues.allSatisfy({ $0 == .unchecked }) else { return }
            word.append(character)
        }
        
        mutating func removeLastCharacter() {
            guard clues.allSatisfy({ $0 == .unchecked }) else { return }
            guard !word.isEmpty else { return }
            word.removeLast()
        }
        
        mutating func test(against correctWord: String) {
            let correct = Array(correctWord.lowercased())
            let guess = Array(word.lowercased())
            
            var clues = Array(repeating: Clue.unchecked, count: length)
            
            var usedIndices = Set<Int>()
            
            //check to see if any match up
            for i in 0..<guess.count {
                if correct[i] == guess[i] {
                    clues[i] = .correct
                    usedIndices.insert(i)
                }
            }
            
            for i in 0..<guess.count {
                if clues[i] == .unchecked {
                    let check = guess[i]
                    for j in 0..<correct.count {
                        if usedIndices.contains(j) {
                            continue
                        }
                        if check == correct[j] {
                            clues[i] = .present
                            usedIndices.insert(j)
                            break
                        }
                    }
                }
            }
            
            self.clues = clues.map { $0 == .unchecked ? .notPresent : $0 }
        }
    }
}
