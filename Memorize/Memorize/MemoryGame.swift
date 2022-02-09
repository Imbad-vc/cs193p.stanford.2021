//
//  MemoryGame.swift
//  Memorize
//
//  Created by LuChen on 2022/1/3.
//

import Foundation

struct MemoryGame<CardContent>where CardContent: Equatable {
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    private(set) var score = 0
    private(set) var cards:Array<Card>
    private var seenCardIndexs:Array<Int> = []
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
           cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)}
//            for index in cards.indices {
//                cards[index].isFaceUp = index == newValue
//                if index != newValue {
//                    cards[index].isFaceUp = false
//                }else{
//                    cards[index].isFaceUp = true
//                }
//            }
        }
    }
    
    init(numbersOfPairsOfCards:Int, createCardContent:(Int)->CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numbersOfPairsOfCards {
            let content:CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
       cards.shuffle()
    }
    
    mutating func shuffle() {
       cards.shuffle()
    }
    
    mutating func choose(_ card:Card) {
        if let chooseIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chooseIndex].isFaceUp,
           !cards[chooseIndex].isMatched {
            //check cards is already be seen
            if (!seenCardIndexs.contains(chooseIndex)) {
                seenCardIndexs.append(chooseIndex)
            }
            let choosedCardContent = cards[chooseIndex].content
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                let potentialMatchContent = cards[potentialMatchIndex].content
                if choosedCardContent == potentialMatchContent {
                    cards[chooseIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    //remove matced index
                    seenCardIndexs.remove(at: seenCardIndexs.firstIndex(where: { $0 == chooseIndex})!)
                    seenCardIndexs.remove(at: seenCardIndexs.firstIndex(where: { $0 == potentialMatchIndex})!)
                    score += 2
                }
                
                if seenCardIndexs.filter({
                    let seenCardContent = cards[$0].content
                    return seenCardContent == choosedCardContent || seenCardContent == potentialMatchContent
                }).count > 2 {
                    score -= 1
                }
               
            }else{
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
            }
            cards[chooseIndex].isFaceUp.toggle()
        }
        
    }
    
//    func index(of card:Card) -> Int? {
//        for index in 0..<cards.count {
//            if cards[index].id == card.id{
//                return index
//            }
//
//        }
//        return nil
//    }
}


extension Array {
    var oneAndOnly: Element? {
        get{
           count == 1 ? first : nil
        }
    }
}
