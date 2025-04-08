//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Bruce on 2025/4/4.
//

import SwiftUI


//ViewModel
class EmojiMemorizeGame : ObservableObject {
    //静态属性是类级的全局变量,在实例属性初始化之前就已经初始化完成.实例属性 model 可以使用此静态属性 来初始化它自己
    private static let emojis = ["👻","🎃","🤖","🐼","🐰","🐭","🦊","🐯","🐻","🌸","🐷"]
    
    private static func createMomorizeGame() -> MemorizeGame<String>{
        MemorizeGame(numberOfPairsOfCards: 10) { pairIndex in    //为了可读性,不会简化为 $0
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            return "⁉️"
        }
    }
    
    
    /*
     @published
     @Published 是一个属性包装器，用来修饰类中的属性，使它成为可以被观察到的状态
     */
    @Published private var model = createMomorizeGame()
    
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    // MARK: -   Intents
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose (_ card : MemorizeGame<String>.Card){
        model.choose(card)
    }
    
}
