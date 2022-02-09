//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by LuChen on 2022/1/5.
//

import Foundation

struct MemoryGameTheme {
    private(set) var name:String
    private(set) var emojis:Array<String>
    private(set) var numberOfPairs:Int
    private(set) var cardColor:String
    
    init(name:String,emojis:Array<String>,numberOfPairs:Int,cardColor:String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs
        self.cardColor = cardColor
    }
    
    static var themes:Array<MemoryGameTheme> = [
        MemoryGameTheme(name:"Animals",
                        emojis: ["🐳","🐋","🦈","🦭","🐊","🐅","🐆","🦓","🦍","🦧","🦣","🐘","🦛","🦏","🐪","🐫","🦒","🦘","🦬","🐃","🐄","🐂","🐎","🐖","🐏","🦙","🐐","🦌"],
                        numberOfPairs: 5,
                        cardColor: "red"),
        MemoryGameTheme(name: "Food",
                        emojis: ["🥐","🥯","🍞","🥖","🥨","🧀","🧈","🥞","🧇","🥓","🌭","🍟","🍔","🍳"],
                        numberOfPairs: 5,
                        cardColor: "orange"),
        MemoryGameTheme(name: "Sports",
                        emojis: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓","🏸"],
                        numberOfPairs: 8,
                        cardColor: "gray"),
        MemoryGameTheme(name: "Cars",
                        emojis: ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🛺","🚔","🚍"],
                        numberOfPairs: 4,
                        cardColor: "green"),
        MemoryGameTheme(name: "Hearts",
                        emojis: ["❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎","❤️‍🔥","❤️‍🩹"],
                        numberOfPairs: 8,
                        cardColor: "yellow"),
        MemoryGameTheme(name: "Flags",
                        emojis: ["🏳️","🏴","🏴‍☠️","🏁","🚩","🏳️‍🌈","🏳️‍⚧️","🇺🇳","🇦🇱","🇩🇿","🇦🇫","🇦🇷","🇦🇪","🇦🇼","🇴🇲","🇦🇿","🇪🇬","🇪🇹"],
                        numberOfPairs: 15,
                        cardColor: "black"),
    ]
    
}
