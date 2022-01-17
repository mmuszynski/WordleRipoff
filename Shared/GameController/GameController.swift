//
//  GameController.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/11/22.
//

import Foundation
import SwiftUI

public class GameController: ObservableObject {
    
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
    
    public init() {}
    
    @Published var wordListSelection: WordListSelection = .unix {
        didSet {
            self.wordList = wordListSelection.wordListInitializer(wordLength)
            self.reset()
        }
    }
    @Published var wordLength: Int = 5 {
        didSet {
            self.wordList = wordListSelection.wordListInitializer(wordLength)
            self.reset()
        }
    }
    var guesses = [Guess()]
    
    lazy var wordList: WordList = wordListSelection.wordListInitializer(wordLength)
    lazy var correctWord: String = self.wordList.getRandomWord()

    func reset() {
        self.guesses = [Guess(length: wordLength)]
        self.getNewWord()
        self.error = nil
        self.errorTimer?.invalidate()
        self.errorTimer = nil
        
        objectWillChange.send()
    }
    
    func getNewWord() {
        correctWord = wordList.getRandomWord()
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
        guard guess.word.count == self.wordLength else {
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
            guesses.append(Guess(length: self.wordLength))
        } else {
            self.error = .failure(correctWord)
        }
        
        objectWillChange.send()
    }
    
}
