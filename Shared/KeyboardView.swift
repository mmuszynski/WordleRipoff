//
//  KeyboardView.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/17/22.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var gameController: GameController
    
    let row1 = Array("qwertyuiop".uppercased())
    let row2 = Array("asdfghjkl".uppercased())
    let row3 = Array("zxcvbnm".uppercased())
    
    var keySize: Double = 40
    
    var body: some View {
        VStack(spacing: keySize / 6) {
            ForEach([row1, row2, row3], id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { letter in
                        let clue = gameController.clueForLetter[letter]
                        Text(String(letter))
                            .frame(maxWidth: keySize, maxHeight: keySize)
                            .aspectRatio(1, contentMode: .fill)
                            .background(clue?.color ?? GameController.Clue.unchecked.color)
                            .border(.black)
                    }
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .environmentObject(GameController.example)
    }
}
