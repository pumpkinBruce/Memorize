//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Bruce on 2025/4/4.
//

import SwiftUI

/*
 emojis 设为全局变量可以让 model 属性用来初始化,
 但是全局变量会被 View model 和 ViewModel 都可以访问.
 所以 emojis 不放在这里.放在 class 中作为静态属性
 */
//let emojis = ["👻","🎃","🤖","🐼","🐰","🐭","🦊","🐯","🐻","🌸","🐷"]

//ViewModel
class EmojiMemorizeGame : ObservableObject {
    //静态属性是类级的全局变量,在实例属性初始化之前就已经初始化完成.实例属性 model 可以使用此静态属性 来初始化它自己
    private static let emojis = ["👻","🎃","🤖","🐼","🐰","🐭","🦊","🐯","🐻","🌸","🐷"]
    
    private static func createMomorizeGame() -> MemorizeGame<String>{
        MemorizeGame(numberOfPairsOfCards: 10) { pairIndex in    //为了可读性,不会简化为 $0
            if emojis.indices.contains(pairIndex) {
                // cardContentFactory: { (index : Int) -> String in   // closure 可以省略返回值类型 参数类型 和 参数列表的括号
                return emojis[pairIndex]
            }
            return "⁉️"
        }
    }
    
    
    /*
     部分分离: 在 View 页面中,有一个 viewModel 属性,通过 viewModel 访问 Model.
     如果想要实现完全分离,将 model 属性设置为 private
     
     @published
     @Published 是一个属性包装器，用来修饰类中的属性，使它成为可以被观察到的状态
     
     当你在 ObservableObject 类中用 @Published 修饰一个属性时，只要这个属性的值发生变化，所有观察这个对象的视图（比如使用 @ObservedObject 或 @StateObject）都会自动刷新 UI！
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
        return model.choose(card)
    }
    
}
