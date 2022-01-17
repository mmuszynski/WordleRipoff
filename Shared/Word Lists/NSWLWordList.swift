//
//  NSWLWordList.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

class NSWLWordList: WordList {
    override init(wordLength: Int? = nil) {
        super.init()
        let url = Bundle.main.url(forResource: "NSWL2018", withExtension: "txt")!
        let rawList = try! String(contentsOf: url)
        
        let words = rawList.components(separatedBy: .newlines).compactMap { $0.components(separatedBy: " ").first }
        
        let fiveLetterWords = words.filter { $0.count == wordLength ?? 5 }
        self.words = fiveLetterWords.map { $0.uppercased() }
    }
}
