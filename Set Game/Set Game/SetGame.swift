//
//  SetGame.swift
//  Set Game
//
//  Created by dans.domanevskis on 16/04/2020.
//  Copyright © 2020 dans.domanevskis. All rights reserved.
//

import Foundation

struct SetGame
{
    var totalScore = 0
    private var deck = [Card]()
    private(set) var tableCard = [Card]()
    private var selectedCard = [Card]()
    
    var numberOfCards: Int {
        return deck.count
    }
    
    mutating func chooseCard(at index: Int) {
        if selectedCard.contains(tableCard[index]) {
            selectedCard.remove(at: selectedCard.firstIndex(of: tableCard[index])!)
            return
        }
        if selectedCard.count == 3 {
            if isSet(on: selectedCard) {
                for cards in selectedCard {
                    tableCard.remove(at: tableCard.firstIndex(of: cards)!)
                }
                selectedCard.removeAll()
                addThree()
                totalScore += 1
            } else {
                selectedCard.removeAll()
                totalScore -= 1
            }
        }
        selectedCard += [tableCard[index]]
    }
    
    mutating func isSet(on selectedCard: [Card]) -> Bool {
        let shape = Set(selectedCard.map{ $0.shape }).count
        let number = Set(selectedCard.map{ $0.number }).count
        let color = Set(selectedCard.map{ $0.color }).count
        let fill = Set(selectedCard.map{ $0.fill }).count
        return shape != 2 && number != 2 && color != 2 && fill != 2
    }
    
    mutating func addThree() {
        if deck.count > 0 {
            for _ in 1...3 {
                tableCard += [deck.remove(at: deck.randomIndex)]
            }
        }
    }
    
    private mutating func startDeck() {
        for _ in 1...4 {
            addThree()
        }
    }
    
    mutating func scoreReset() {
        totalScore = 0
    }
    
    init() {
        for shape in Card.Shape.all {
            for number in Card.Number.all {
                for color in Card.Color.all {
                    for fill in Card.Fill.all {
                        let card = Card(with: shape, number, color, fill)
                        deck += [card]
                    }
                }
            }
        }
        startDeck()
    }
}
    
extension Array {
    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count - 1)))
    }
}
