//
//  ContentView.swift
//  Shared
//
//  Created by Mike Muszynski on 1/11/22.
//

import SwiftUI

extension Collection {
    subscript(optional index: Self.Index) -> Element? {
        guard self.indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}

struct ContentView: View {
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                ForEach(0..<6) { i in
                    WordView(guess: gameController.guesses[optional: i])
                }
            }
            
            Text(gameController.error?.description ?? "")
                .animation(nil)
                .font(Font.largeTitle)
                .foregroundColor(.white)
                .frame(width: 400, height: 150, alignment: .center)
                .background(Color(.displayP3, white: 0.25, opacity: 0.85))
                .cornerRadius(10.0)
                .opacity(gameController.error == nil ? 0.0 : 1.0)
                .animation(.easeInOut(duration: 0.25))
            
        }
        .padding()
        .background(KeyEventHandling(gameController: self.gameController))
    }
}

extension GameController {
    func guessWord(_ word: String) {
        for letter in word {
            self.respond(to: letter)
        }
        self.finalizeGuess()
    }
    
    static var example: GameController {
        let gc = GameController()
        gc.correctWord = "DRINK"
        gc.guessWord("PERCH")
        gc.guessWord("PRINT")
        gc.guessWord("DRIVE")
        gc.guessWord("DRINK")
        
        for letter in "DR" {
            gc.respond(to: letter)
        }
        return gc
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .colorScheme(.dark)
        }
        .environmentObject(GameController.example)
    }
}
