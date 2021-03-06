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
                        emojis: ["π³","π","π¦","π¦­","π","π","π","π¦","π¦","π¦§","π¦£","π","π¦","π¦","πͺ","π«","π¦","π¦","π¦¬","π","π","π","π","π","π","π¦","π","π¦"],
                        numberOfPairs: 5,
                        cardColor: "red"),
        MemoryGameTheme(name: "Food",
                        emojis: ["π₯","π₯―","π","π₯","π₯¨","π§","π§","π₯","π§","π₯","π­","π","π","π³"],
                        numberOfPairs: 5,
                        cardColor: "orange"),
        MemoryGameTheme(name: "Sports",
                        emojis: ["β½οΈ","π","π","βΎοΈ","π₯","πΎ","π","π","π₯","π±","πͺ","π","πΈ"],
                        numberOfPairs: 8,
                        cardColor: "gray"),
        MemoryGameTheme(name: "Cars",
                        emojis: ["π","π","π","π","π","π","π","π","π","π","π»","π","π","π","πΊ","π","π"],
                        numberOfPairs: 4,
                        cardColor: "green"),
        MemoryGameTheme(name: "Hearts",
                        emojis: ["β€οΈ","π§‘","π","π","π","π","π€","π€","π€","β€οΈβπ₯","β€οΈβπ©Ή"],
                        numberOfPairs: 8,
                        cardColor: "yellow"),
        MemoryGameTheme(name: "Flags",
                        emojis: ["π³οΈ","π΄","π΄ββ οΈ","π","π©","π³οΈβπ","π³οΈββ§οΈ","πΊπ³","π¦π±","π©πΏ","π¦π«","π¦π·","π¦πͺ","π¦πΌ","π΄π²","π¦πΏ","πͺπ¬","πͺπΉ"],
                        numberOfPairs: 15,
                        cardColor: "black"),
    ]
    
}
