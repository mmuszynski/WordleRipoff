//
//  WashUnivWordList.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/16/22.
//

import Foundation

class WashUnivWordList: WordList {
    override init(wordLength: Int? = nil) {
        super.init()
        let url = Bundle.main.url(forResource: "WASHU", withExtension: "csv")!
        let rawList = try! String(contentsOf: url)
        
        let words = rawList.components(separatedBy: .newlines).compactMap { $0.components(separatedBy: ",").first }
        self.words = words
        
    }
}
