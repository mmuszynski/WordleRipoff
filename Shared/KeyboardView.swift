//
//  KeyboardView.swift
//  WordleRipoff
//
//  Created by Mike Muszynski on 1/17/22.
//

import SwiftUI

struct KeyboardView: View {
    let row1 = Array("qwertyuiop")
    let row2 = Array("asdfghjkl")
    let row3 = Array("zxcvbnm")
    
    var keySize: Double = 40
    
    var body: some View {
        VStack(spacing: keySize / 6) {
            ForEach([row1, row2, row3], id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { letter in
                        Text(String(letter))
                            .frame(maxWidth: keySize, maxHeight: keySize)
                            .aspectRatio(1, contentMode: .fill)
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
    }
}
