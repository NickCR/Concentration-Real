//
//  Concentration.swift
//  Concentration
//
//  Created by Jelly Slather on 1/30/18.
//  Copyright © 2018 Rudinski. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    //you can look at the cards but I decide if they're up and down or matches
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            //bool function that returns true if it's face up
 /*
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                         //if you found the only face up the remember it
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
 */
        }
        set {
            //set is already mutable by default on a var
            //get is not mutable by default
            
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                //index == newValue true means it's face up
            }
            //go through all cards and set face down except the face up one
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0,  "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        //if index doesn't exist in cards then crash and print that text
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
