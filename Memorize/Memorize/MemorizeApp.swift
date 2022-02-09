//
//  MemorizeApp.swift
//  Memorize
//
//  Created by LuChen on 2021/12/31.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
