//
//  ViewController.swift
//  Concentration Demo
//
//  Created by dans.domanevskis on 16/04/2020.
//  Copyright © 2020 dans.domanevskis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = SetGame()
    private var chosenButtons = [UIButton]()

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreCountLabel: UILabel!
    @IBOutlet weak private var threeCards: UIButton!
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = SetGame()
        resetButtons()
        game.scoreReset()
        chosenButtons.removeAll()
        hideAdd3Button()
        updateViewFromModel()
    }
    
    @IBAction func addThreeCards(_ sender: UIButton) {
        game.addThree()
        updateViewFromModel()
        hideAdd3Button()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            if cardNumber < game.tableCard.count {
                game.chooseCard(at: cardNumber)
                showSelected(at: sender)
                updateViewFromModel()
            }
        } else {
            print("Chosen card not in cardButtons")
        }
    }
    
    private func updateScore() {
        scoreCountLabel.text = "Score: \(game.totalScore)"
    }
    
    private func showSelected(at card: UIButton) {
        if chosenButtons.contains(card) {
            card.layer.borderColor = #colorLiteral(red: 0.9956058964, green: 1, blue: 0.99952356, alpha: 0)
            card.layer.borderWidth = 3.0
            chosenButtons.remove(at: chosenButtons.firstIndex(of: card)!)
            return
        } else if chosenButtons.count == 3 {
            cardButtons.forEach() { $0.layer.borderColor = #colorLiteral(red: 1, green: 0.06248319769, blue: 0.08135498834, alpha: 0) }
            chosenButtons.removeAll()
            updateViewFromModel()
            updateScore()
        }
        chosenButtons += [card]
        card.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        card.layer.borderWidth = 3.0
    }
    
    private func hideAdd3Button() {
        if game.tableCard.count == 24 || game.numberOfCards == 0 {
            threeCards.isHidden = true
        } else {
            threeCards.isHidden = false
        }
    }
    
    private func resetButtons() {
        for button in cardButtons {
            let blankTile = NSAttributedString(string: "")
            button.setAttributedTitle(blankTile, for: .normal)
        }
    }
    
    private func updateViewFromModel() {
        for index in game.tableCard.indices {
            cardButtons[index].titleLabel?.numberOfLines = 0
            cardButtons[index].setAttributedTitle(colorCards(with: game.tableCard[index]), for: .normal)
            // Add a check for less than 24 cards 
        }
    }
    
    private func colorCards(with card: Card) -> NSAttributedString {
        let shape: String = cardParams.shapes[card.shape]!
        var returnString: String
            
        switch card.number {
        case .one: returnString = shape
        case .two: returnString = shape + "\n" + shape
        case .three: returnString = shape + "\n" + shape + "\n" + shape
        }
            
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeColor : cardParams.colors[card.color]!,
            .strokeWidth : cardParams.strokeFill[card.fill]!,
            .foregroundColor: cardParams.colors[card.color]!.withAlphaComponent(cardParams.alpha[card.fill]!)
        ]
        return NSAttributedString(string: returnString, attributes: attributes)
    }
    
    struct cardParams {
        static let shapes: [Card.Shape: String] = [.circle: "●", .triangle: "▲", .square: "■"]
        static let colors: [Card.Color: UIColor] = [.red: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), .purple: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), .green: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
        static let alpha: [Card.Fill: CGFloat] = [.solid: 1.0, .empty: 0.40, .striped: 0.15]
        static let strokeFill: [Card.Fill: CGFloat] = [.solid: -5, .empty: 5, .striped: -5]
    }
}
