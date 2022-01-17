//
//  WordList.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/11/22.
//

import Foundation

public class WordList {
    public typealias Element = String
    
    var words: [Element] = []
    var wordLength: Int = 5
    
    @available(*, message: "This abstract class must be subclassed")
    public init(wordLength: Int? = nil) {}
    
    func getRandomWord() -> String {
        return words.randomElement()!
    }
}

extension WordList: Collection {
    public subscript(position: Int) -> String {
        get {
            return words[position]
        }
    }
    
    public var startIndex: Array<Element>.Index { words.startIndex }
    public var endIndex: Array<Element>.Index { words.endIndex }
    public func index(after i: Array<Element>.Index) -> Array<Element>.Index {
        words.index(after: i)
    }
}

extension WordList: RandomAccessCollection {
    
}
