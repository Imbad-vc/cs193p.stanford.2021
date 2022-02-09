//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by LuChen on 2022/1/3.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
//    static func createMemoryGame() -> MemoryGame<String> {
//        MemoryGame<String>(numbersOfPairsOfCards: 3){
//            pairIndex in
//            emojis[pairIndex]
//        }
//    }
    
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model:MemoryGame<String>
    private(set) var theme:MemoryGameTheme = MemoryGameTheme.themes.randomElement()!
    
    init(theme:MemoryGameTheme? = nil) {
        let emojis = self.theme.emojis.shuffled()
        self.model = MemoryGame(numbersOfPairsOfCards: self.theme.numberOfPairs){
            emojis[$0]
        }
    }
    
    var score:Int {
       return model.score
    }
    
    var themeName:String {
        return theme.name
    }
    
    var themeColor:Color? {
        switch theme.cardColor {
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        case "gray":
            return Color.gray
        case "yellow":
            return Color.yellow
        case "black":
            return Color.black
            
        default:
            return Color.red
        }
        
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    func choose(_ card:Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        self.theme = MemoryGameTheme.themes.randomElement()!
        let emojis = self.theme.emojis.shuffled()
        self.model = MemoryGame<String>(numbersOfPairsOfCards: self.theme.numberOfPairs){
            emojis[$0]
        }
    }
}

