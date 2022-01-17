//
//  WordleRipoffApp.swift
//  Shared
//
//  Created by Mike Muszynski on 1/11/22.
//

import SwiftUI

@main
struct WordleRipoffApp: App {
    @StateObject var gameController: GameController = GameController()
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
                    .keyboardShortcut("d")
                Divider()
                Picker("Load Word List", selection: $gameController.wordListSelection) {
                    ForEach(GameController.WordListSelection.allCases, id: \.self) { selection in
                        Text(selection.description)
                    }
                }
                Picker("Set Word Length", selection: $gameController.wordLength) {
                    ForEach(4..<7, id: \.self) { length in
                        Text("\(length)")
                    }
                }
            }
        }
    }
}
