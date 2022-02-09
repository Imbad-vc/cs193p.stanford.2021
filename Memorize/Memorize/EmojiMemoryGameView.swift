//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by LuChen on 2021/12/31.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                HStack{
                    Text(game.themeName).font(.largeTitle)
                    Spacer()
                    Text("Score:" + String(game.score))
                }
                gameBody
                Spacer()
                HStack {
                    newGameBtn
                    Spacer()
                    shuffle
                }
            }
            deckBody
        }
        .padding(.horizontal)
        

    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnmation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex (of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            }else{
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                        
                    }
            }
        }
        .foregroundColor(game.themeColor)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(game.themeColor)
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealAnmation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.easeInOut(duration: 5)) {
                game.shuffle()
            }
            
        }
    }
    
    var newGameBtn: some View {
        Button {
            withAnimation {
                dealt = []
                game.newGame()
            }
            
        } label: {
            Text("New Game")
        }
    }
    
    private struct CardConstants {
//        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
    
//    @ViewBuilder
//    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
//        if card.isMatched && !card.isFaceUp {
//            Rectangle().opacity(0)
//        }else{
//            CardView(card: card)
//                .padding(4)
//                .onTapGesture {
//                    game.choose(card)
//                }
//        }
//    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
//
//    init(_ card:EmojiMemoryGame.Card) {
//        self.card = card
//    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation (.linear(duration: card.bonusRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    }else{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .padding(5)
                .opacity(0.55)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 2))
                    .font(Font.system(size: 32))
                    .scaleEffect(scale(thatFits:geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        
    }
    
    private func scale(thatFits size:CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size:CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale:CGFloat = 0.7
        static let fontSize:CGFloat = 32
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
