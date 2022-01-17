//
//  OGWordList.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

class OGWordList: WordList {
    
    var correctWords: [String] = []
    
    override init(wordLength: Int? = nil) {
        super.init()
        let url = Bundle.main.url(forResource: "OGappropriateGuesses", withExtension: "txt")!
        let rawList = try! String(contentsOf: url)
        
        let words = rawList.components(separatedBy: .newlines)
        self.words = words.map { $0.uppercased() }
        
        let correctWordURL = Bundle.main.url(forResource: "OGcorrectWords", withExtension: "txt")!
        let list2 = try! String(contentsOf: correctWordURL)
        
        let correct = list2.components(separatedBy: .newlines)
        self.correctWords = correct.map { $0.uppercased() }
    }
    
    override func getRandomWord() -> String {
        return self.correctWords.randomElement()!
    }
}
