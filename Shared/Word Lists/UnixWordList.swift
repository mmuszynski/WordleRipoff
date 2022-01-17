//
//  UnixWordList.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

class UnixWordList: WordList {
    override init(wordLength: Int? = nil) {
        super.init()
        let url = URL(fileURLWithPath: "/usr/share/dict/words")
        let rawList = try! String(contentsOf: url)
        let fiveLetterWords = rawList.components(separatedBy: .whitespacesAndNewlines).filter { $0.lengthOfBytes(using: .utf8) == wordLength ?? 5 }
        self.words = fiveLetterWords.map { $0.uppercased() }
    }
}
