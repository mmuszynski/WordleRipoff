//
//  WordleRipoffApp.swift
//  Shared
//
//  Created by Mike Muszynski on 1/11/22.
//

import SwiftUI

@main
struct WordleRipoffApp: App {
    var gameController: GameController = GameController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameController)
        }
        .commands {
            CommandMenu("Game") {
                Button(action: { gameController.reset() },
                       label: { Text("Reset") })
                    .keyboardShortcut("r")
                Button(action: { gameController.error = GameController.GameError.debug(word: gameController.correctWord) },
                       label: { Text("Debug") })
                    .keyboardShortcut("r")
                Divider()
                Menu("Load Word List") {
                    Button(action: { gameController.wordList = WordList() },
                           label: { Text("Unix") })
                    Button(action: { gameController.wordList = FrequencyWordList() },
                           label: { Text("Frequency") })
                    Button(action: { gameController.wordList = NSWLWordList() },
                           label: { Text("NSWL") })
                }
            }
        }
    }
}
