//
//  Cardify.swift
//  Memorize
//
//  Created by LuChen on 2022/1/12.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var isFaceUp = false
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    //test this's a
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
//            let shape = Circle()
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            }else{
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)

        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius:CGFloat = 4
        static let lineWidth:CGFloat = 3
//        static let fontScale:CGFloat = 0.7
    }
}

extension View {
    func cardify(isFaceUp:Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
