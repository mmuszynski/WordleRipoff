//
//  Keypress.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/15/22.
//

import Foundation
import SwiftUI

struct KeyEventHandling: NSViewRepresentable {
    var gameController: GameController?
    
    class KeyView: NSView {
        var gameController: GameController?
        
        override var acceptsFirstResponder: Bool { true }
        override func keyDown(with event: NSEvent) {
            
            switch event.keyCode {
            case 36:
                gameController?.finalizeGuess()
            case 117, 51:
                gameController?.deleteLastCharacter()
            default:
                guard let character = event.characters?.first else { return }
                gameController?.respond(to: character)
            }
        }
    }

    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        view.gameController = self.gameController
        DispatchQueue.main.async { // wait till next event cycle
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

struct TestKeyboardEventHandling: View {
    var body: some View {
        Text("Hello, World!")
            .background(KeyEventHandling())
    }
}
