//
//  ViewController.swift
//  Concentration
//
//  Created by Jelly Slather on 1/29/18.
//  Copyright © 2018 Rudinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
   
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    private(set) var flipCount = 0{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    private(set) var pointTotal = 0{
        didSet{
            pointTotalLabel.text = "Points: \(pointTotal)"
        }
    }
    

    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
             updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var pointTotalLabel: UILabel!
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func newGame(_ sender: UIButton) {
        flipCount = 0
        pointTotal = 0
        var emojiChoices = (getChoices(emojiChoiceMaster: [0: emojiChoices0, 1: emojiChoices1, 2: emojiChoices2, 3: emojiChoices3, 4: emojiChoices4, 5: emojiChoices5]))
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }

    }
    private var emojiChoices0 = ["🎃", "👻", "🍬", "🍭", "🦇", "🍎", "🙀"]
    private var emojiChoices1 = ["🐶", "🐱", "🦊", "🐼", "🐨", "🐷", "🐧"]
    private var emojiChoices2 = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏓"]
    private var emojiChoices3 = ["🍏", "🍇", "🍊", "🍋", "🍌", "🍉", "🍓"]
    private var emojiChoices4 = ["🎻", "🎺", "🎸", "🎤", "🎹", "🥁", "🎷"]
    private var emojiChoices5 = ["❄️", "⛄️", "⛸", "🌨", "☂️", "🌪", "🏙"]
    
    
    private func getChoices(emojiChoiceMaster: Dictionary<Int, Array<String>>) -> [String]{
        let randomVal = Int(arc4random_uniform(UInt32(emojiChoiceMaster.count)))
        emojiChoices = Array(emojiChoiceMaster.values)[randomVal]
        return emojiChoices
    }
    private lazy var emojiChoices = (getChoices(emojiChoiceMaster: [0: emojiChoices0, 1: emojiChoices1, 2: emojiChoices2, 3: emojiChoices3, 4: emojiChoices4, 5: emojiChoices5]))
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            //calls the extension to make it look clearer
        }
            return emoji[card] ?? "?"
        
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
            //abs is absolute value
        } else {
            return 0
        }
        //adding all the elses make it so it doesn't crash
    }
}
