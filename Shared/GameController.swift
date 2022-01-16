//
//  GameController.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/11/22.
//

import Foundation
import SwiftUI

extension Color {
    static let uncheckedClueColor = Color("UncheckedClueColor")
    static let presentClueColor = Color("PresentClueColor")
    static let notPresentClueColor = Color("NotPresentClueColor")
    static let correctClueColor = Color("CorrectClueColor")
    static let emptyCellColor = Color("EmptyCellColor")
}

public class GameController: ObservableObject {
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
    
    enum GameError: Error, CustomStringConvertible {
        case notInList(_ word: String)
        case notEnoughLetters
        case victory
        case failure(_ word: String)
        case debug(word: String)
        
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
        
        var allowsContinuation: Bool {
            switch self {
            case .victory, .failure(_):
                return false
            default:
                return true
            }
        }
    }
    
    var errorTimer: Timer?
    @Published var error: GameError? = nil {
        didSet {
            guard error?.allowsContinuation == true else { return }
            errorTimer = Timer(fire: Date() + 3, interval: 0, repeats: false, block: { timer in
                self.error = nil
                self.errorTimer?.invalidate()
                self.errorTimer = nil
            })
            RunLoop.main.add(errorTimer!, forMode: .common)
        }
    }
    
    struct Guess {
        var word = ""
        var clues = Array(repeating: Clue.unchecked, count: 5)
        
        init(word: String, clues: Array<Clue>) {
            self.word = word
            self.clues = clues
        }
        
        init() {}
        
        mutating func respond(to character: Character) {
            let character = character.uppercased()
            guard word.count < 5 else { return }
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
            
            var clues = Array(repeating: Clue.unchecked, count: 5)
            
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
    
    public init() {}
    
    lazy var correctWord: String = self.wordList.randomElement()!
    var guesses = [Guess()]
    var wordList: WordList = NSWLWordList()
    
    func reset() {
        self.guesses = [Guess()]
        self.getNewWord()
        self.error = nil
        objectWillChange.send()
    }
    
    func getNewWord() {
        correctWord = wordList.randomElement()!
    }
    
    func getLastGuess() -> Guess {
        let lastGuessIndex = guesses.index(before: guesses.endIndex)
        return guesses[lastGuessIndex]
    }
    
    func replaceLastGuess(with guess: Guess) {
        let lastGuessIndex = guesses.index(before: guesses.endIndex)
        guesses[lastGuessIndex] = guess
        objectWillChange.send()
    }
    
    func deleteLastCharacter() {
        guard error?.allowsContinuation != false else { return }
        var guess = getLastGuess()
        guess.removeLastCharacter()
        self.replaceLastGuess(with: guess)
    }
    
    func respond(to character: Character) {
        guard error?.allowsContinuation != false else { return }
        guard character.isLetter else { return }
        
        var guess = getLastGuess()
        guess.respond(to: character)
        replaceLastGuess(with: guess)
    }
    
    func finalizeGuess() {
        guard error?.allowsContinuation != false else { return }
        var guess = getLastGuess()
        guard guess.word.count == 5 else {
            self.error = GameError.notEnoughLetters
            return
        }
        
        guard wordList.contains(guess.word) else {
            self.error = GameError.notInList(guess.word)
            return
        }
        
        guess.test(against: self.correctWord)
        replaceLastGuess(with: guess)
        
        if guess.word == correctWord {
            self.error = .victory
            return
        }
        
        if guesses.count < 6 {
            guesses.append(Guess())
        } else {
            self.error = .failure(correctWord)
        }
        
        objectWillChange.send()
    }
    
}
