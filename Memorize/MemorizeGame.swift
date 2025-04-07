//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Bruce on 2025/4/4.
//

import Foundation


//Model
struct MemorizeGame<CardContent> {
    /*
     访问控制:
        我们希望卡片的内容 和 翻转 由 model 自己决定.但是又希望卡片内容可以被 ViewModel 访问.
        所以将 cards 的 set 设为 private
     */
    private(set) var cards : Array<Card>
    
    /*
     numberOfPairsOfCards: 多少对卡片
     cardContentFactory: 一个创建卡片内容的函数
     */
    init(numberOfPairsOfCards:Int, cardContentFactory : (Int) -> CardContent) {    //函数式编程,调用一个函数来生成卡片内容
        cards = []
        //卡片对数至少为2对
        for pairsIndex in 0 ..< max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairsIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    
    func choose (_ card : Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true    //默认朝下
        var isMatched = false   //默认未匹配
        var content : CardContent
    }
    
}


