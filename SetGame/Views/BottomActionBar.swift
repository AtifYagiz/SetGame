//
//  BottomActionBar.swift
//  SetGame
//
//  Created by Vakhtang Saginadze on 12.03.2024.
//

import SwiftUI

struct ButtonStyling: ViewModifier {
    var noMoreCards: Bool
    
    init(_ noMoreCards: Bool = false) {
        self.noMoreCards = noMoreCards
    }
    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundStyle(.white)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(noMoreCards ? .gray : .black)
            }
            .disabled(noMoreCards)
    }
}

struct BottomActionBar: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        HStack {
            shuffleButton
            
            Spacer()
            
            addThreeCardsButton
        }
        .padding(.top)
    }
    
    private var addThreeCardsButton: some View {
        Button {
            withAnimation {
                game.addThreeCards()
            }
        } label: {
            Image(systemName: "square.stack.3d.up.fill")
                .font(.title3)
            Text("Add 3 Cards")
        }
        .modifier(ButtonStyling(game.noMoreCards))
    }
    
    private var shuffleButton: some View {
        Button {
            withAnimation {
                game.shuffle()
            }
        } label: {
            Text("Shuffle")
            Image(systemName: "shuffle")
        }
        .modifier(ButtonStyling())
    }
}

#Preview {
    BottomActionBar(game: SetGameViewModel())
}
