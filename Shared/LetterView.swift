//
//  ContentView.swift
//  Shared
//
//  Created by Mike Muszynski on 1/11/22.
//

import SwiftUI

struct LetterView: View {
    var letter: String?
    var clue: GameController.Clue?
    
    @Environment(\.colorScheme) var colorScheme
    var borderColor: Color {
        switch self.colorScheme {
        case .light:
            return Color(.displayP3, white: letter == nil ? 0.55 : 0.25, opacity: 1)
        case .dark:
            return Color(.displayP3, white: letter == nil ? 0.45 : 0.6, opacity: 1)
        @unknown default:
            fatalError()
        }
    }
    
    var body: some View {
        Group {
            if let letter = letter {
                Text(letter)
            } else {
                Text("A")
                    .opacity(0)
            }
        }
        .font(.system(size: 50))
        .frame(width: 100, height: 100, alignment: .center)
        .background(clue?.color ?? .emptyCellColor)
        .border(borderColor, width: 2)
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        let clues = GameController.Clue.allCases
        let clueNames = String(clues.reduce("") { partialResult, clue in
            return partialResult + "\(clue) "
        }.dropLast())
        
        ForEach(ColorScheme.allCases, id: \.self) { darkMode in
            HStack {
                Group {
                    ForEach(GameController.Clue.allCases, id: \.self) { clue in
                        LetterView(letter: "A", clue: clue)
                    }
                    LetterView(letter: nil, clue: .unchecked)
                }
                .preferredColorScheme(darkMode)
            }
            .previewDisplayName("\(clueNames) \(darkMode)")
        }
    }
}
