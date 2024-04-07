//
//  SetGame.swift
//  SetGame
//
//  Created by Vakhtang Saginadze on 08.03.2024.
//

import Foundation

struct SetGameModel {
    private(set) var dealedCards: Array<Card>
    private var deck: Deck
    
    init() {
        dealedCards = []
        deck = Deck()
        
        deal(12)
    }
    
    mutating func choose(_ card: Card) {
        if let selectedCardIdx = dealedCards.firstIndex(where: {$0.id == card.id}) {
            // OPTIMIZE
            var numberOfSelectedCards = 0
            for card in dealedCards {
                if card.isSelected {
                    numberOfSelectedCards += 1
                }
            }
            
            if numberOfSelectedCards == 3 {
                for idx in 0..<dealedCards.count {
                    if dealedCards[idx].isSelected {
                        dealedCards[idx].isSelected.toggle()
                    }
                }
                numberOfSelectedCards = 0
            }
            
            dealedCards[selectedCardIdx].isSelected.toggle()
            
            
            
            if numberOfSelectedCards == 2 {
                check()
            }
        }
    }
    
    func isThereMoreCards() -> Bool {
        return dealedCards.count == 81
    }
    
    mutating func check() {
        var selectedCards: Array<Card> = []
        for card in dealedCards {
            if card.isSelected {
                selectedCards.append(card)
            }
        }
        
        var isSet: Bool = isSet(selectedCards)
    }
    
    func isSet(_ selectedCards: Array<Card>) -> Bool {
        return true
    }
    
    mutating func shuffle() {
        dealedCards.shuffle()
    }

    mutating func deal(_ n: Int = 3) {
        for _ in 0..<n {
            guard let card = deck.getCard() else {
                return
            }
            dealedCards.append(card)
        }
    }
    
    struct Deck {
        private var cards = [Card]()
        
        init() {
            for number in Number.allCases {
                for color in Color.allCases {
                    for shape in Shape.allCases {
                        for shading in Shading.allCases {
                            cards.append(Card(shape: shape, shading: shading, number: number, color: color))
                        }
                    }
                }
            }
            cards.shuffle()
        }
        
        mutating func getCard() -> Card? {
            guard cards.count > 0 else {
                return nil
            }
            return cards.removeFirst()
        }
    }
    
    struct Card: Identifiable {
        // features
        let shape: Shape
        let shading: Shading
        let number: Number
        let color : Color
        
        var isSelected: Bool = false
        var isMatched: Bool = false
        
        var id = UUID()
    }
    
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }

    enum Color: String, CaseIterable, Hashable {
        case red = "🟥", purple = "🟪", green = "🟩"
    }

    enum Shading: String, CaseIterable, Hashable {
        case solid, stripped, outlined
    }

    enum Shape: String, CaseIterable, Hashable {
        case oval , squiggle, diamond
    }
}
