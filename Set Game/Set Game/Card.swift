//
//  Card.swift
//  Set Game
//
//  Created by dans.domanevskis on 13/05/2020.
//  Copyright © 2020 dans.domanevskis. All rights reserved.
//

import Foundation

struct Card
{
    var shape: Shape
    var number: Number
    var color: Color
    var fill: Fill
    
    lazy var matrixValues = [shape.rawValue, number.rawValue, color.rawValue, fill.rawValue] as [Any]
    
    enum Shape: String, CustomStringConvertible {
        case circle = "circle"
        case triangle = "triangle"
        case square = "square"
        static var all = [Shape.circle, .triangle, .square]
        var description: String { return rawValue }
    }
    
    enum Number: Int, CustomStringConvertible {
        case one = 1
        case two
        case three
        static let all = [Number.one, .two, .three]
        var description: String { return String(rawValue)}
    }
    
    enum Color: String, CustomStringConvertible {
        case red = "red"
        case purple = "purple"
        case green = "green"
        static let all = [Color.red, .purple, .green]
        var description: String { return rawValue}
    }
    
    enum Fill: String, CustomStringConvertible {
        case empty = "empty"
        case striped = "striped"
        case solid = "solid"
        static var all = [Fill.empty, .striped, .solid]
        var description: String { return rawValue}
    }
    
    init(with s: Shape, _ n: Number, _ c: Color, _ f: Fill) {
        color = c
        number = n
        shape = s
        fill = f
    }
}

extension Card: CustomStringConvertible {
    var description: String { return "shape: \(shape) number: \(number) color: \(color) fill: \(fill)"}
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.number == rhs.number && lhs.fill == rhs.fill
    }
}

