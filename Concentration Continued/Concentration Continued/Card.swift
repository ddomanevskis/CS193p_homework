//
//  Card.swift
//  Concentration Continued
//
//  Created by dans.domanevskis on 23/04/2020.
//  Copyright © 2020 dans.domanevskis. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    func hash(into hasher: inout Hasher){
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
