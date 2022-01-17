//
//  WordView.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/12/22.
//

import SwiftUI

struct WordView: View {
    @EnvironmentObject var gc: GameController
    var guess: GameController.Guess?
    
    var word: String {
        return guess?.word ?? ""
    }
    
    var clues: [GameController.Clue] {
        return guess?.clues ?? []
    }
    
    var body: some View {
       HStack {
           ForEach(0..<gc.wordLength, id: \.self) { i in
                let index = String.Index(utf16Offset: i, in: word)
                LetterView(letter: word.indices.contains(index) ? String(word[index]) : nil,
                           clue: word.indices.contains(index) ? clues[i] : nil)
            }
        }
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            Group {
                WordView(guess: GameController.Guess(word: "BU", clues: Array(repeating: .unchecked, count: 5)))
                WordView(guess: GameController.Guess(word: "BUTTS", clues: Array(repeating: .notPresent, count: 5)))
                WordView(guess: GameController.Guess(word: "BUTTS",
                         clues: [GameController.Clue.correct, .notPresent, .notPresent, .present, .present]))
            }.colorScheme(scheme)
        }
    }
}
