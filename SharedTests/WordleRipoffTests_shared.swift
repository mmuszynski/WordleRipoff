//
//  WordleRipoffTests_macOS.swift
//  WordleRipoffTests_macOS
//
//  Created by Mike Muszynski on 1/12/22.
//

import XCTest
@testable import WordleRipoff

class WordleRipoffTests_macOS: XCTestCase {

    func testGameControllerInit() {
        let _ = GameController()
    }
    
    func tryOutcome(guess: String, correct: String, clues: [GameController.Clue]) {
        var g = GameController.Guess()
        
        g.word = guess
        g.test(against: correct)
        XCTAssertEqual(g.clues, clues)
    }
    
    func testGameControllerClues() {
        var g = GameController.Guess()
        
        //Test DRIVE vs DRINK [1,1,1,0,0]
        var correctWord = "DRINK"
        let clues: [GameController.Clue] = [.correct, .correct, .correct, .notPresent, .notPresent]
        
        g.word = "DRIVE"
        g.test(against: correctWord)
        XCTAssertEqual(g.clues, clues)
        
        g.word = "drive"
        g.test(against: correctWord)
        XCTAssertEqual(g.clues, clues)

        correctWord = "drink"
        
        g.word = "DRIVE"
        g.test(against: correctWord)
        XCTAssertEqual(g.clues, clues)
        
        g.word = "drive"
        g.test(against: correctWord)
        XCTAssertEqual(g.clues, clues)
        
        //Test a word that is anagrammed
        
        correctWord = "mates"
        g.word = "steam"
        g.test(against: correctWord)
        XCTAssertEqual(g.clues, Array(repeating: GameController.Clue.present, count: 5))
        
        correctWord = "cakes"
        g.word = "dream"
        g.test(against: correctWord)
        XCTAssertEqual(g.clues, [GameController.Clue.notPresent, .notPresent, .present, .present, .notPresent])
        
        g.word = "conks"
        g.test(against: correctWord)
        XCTAssertEqual(g.clues, [GameController.Clue.correct, .notPresent, .notPresent, .present, .correct])
    }
    
    func testCluesWivedVsEagle() {
        tryOutcome(guess: "eagle", correct: "wived", clues: [GameController.Clue.present, .notPresent, .notPresent, .notPresent, .notPresent])
    }
    
    func testWordList() {
        let _ = UnixWordList()
    }
    
    func testFrequencyList() {
        let list = FrequencyWordList()
        for _ in 0..<300 {
            print(list.getRandomWord())
        }
    }

}
