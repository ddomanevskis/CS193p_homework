//
//  Concentration.swift
//  Concentration Continued
//
//  Created by dans.domanevskis on 23/04/2020.
//  Copyright © 2020 dans.domanevskis. All rights reserved.
//

import Foundation

struct Concentration
{
    var flipCount = 0
    
    var totalScore = 0
    
    private var numOfAttempts = 3
    
    private var failedAttempts = 0
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly

        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    totalScore += 2
                    failedAttempts = 0
                } else if cards[matchIndex] != cards[index] && numOfAttempts != failedAttempts {
                    failedAttempts += 1
                } else if cards[matchIndex] != cards[index] && numOfAttempts == failedAttempts {
                    totalScore -= 1
                    failedAttempts = 0
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func keepScore() -> Int {
        return totalScore
    }
    
    mutating func flipCounter() -> Int {
        flipCount += 1
        return flipCount
    }
    
    mutating func scoreReset() {
        flipCount = 0
        totalScore = 0
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init( \(numberOfPairsOfCards)): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            //DONE: cards are now shuffled
            cards.shuffle()
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
