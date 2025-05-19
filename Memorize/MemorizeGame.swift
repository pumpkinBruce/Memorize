//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Bruce on 2025/4/4.


import Foundation


//Model
struct MemorizeGame<CardContent> where CardContent : Equatable {
    
    private(set) var cards : Array<Card>
    
    //得分
    private(set) var score = 0
    
    /*
     numberOfPairsOfCards: 多少对卡片
     cardContentFactory: 一个创建卡片内容的函数
     */
    init(numberOfPairsOfCards:Int, cardContentFactory : (Int) -> CardContent) { //函数式编程,调用一个函数来生成卡片内容
        cards = []
        //卡片对数至少为2对
        for pairsIndex in 0 ..< max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairsIndex)
            cards.append(Card(id: "\(pairsIndex)a", content: content))
            cards.append(Card(id: "\(pairsIndex)b", content: content))
        }
    }
    
    
    /*
     两张卡片面朝上且不匹配.
     当点击下一张卡片时,这两张卡片回翻回面朝下.
     */
    //翻转卡片
    mutating func choose (_ card : Card){
        let choosenIndex = cards.firstIndex{ $0.id == card.id}  //从cards 中找到这张卡片
        if let choosenIndex = choosenIndex {
            /*
             只允许翻转面朝下的卡片.
             若卡片朝上,忽略点击.
             所以条件为 卡片面朝下且未匹配状态, 允许翻转
             */
            if !cards[choosenIndex].isFaceUp && !cards[choosenIndex].isMatched {
                //如果只有一张牌已经翻转起来,尝试匹配
                if let potentialMathIndex = indexOfTheOneAndOblyFaceUpCard {
                    //判断两卡片是否匹配
                    if cards[potentialMathIndex].content == card.content{
                        cards[potentialMathIndex].isMatched = true
                        cards[choosenIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[choosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMathIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                    
                }else{
                    /*
                     设置 indexOfTheOneAndOblyFaceUpCard 的值的情况为:
                        只有这一张牌面朝上
                        已有两张牌面朝上,这是第三张牌翻面朝上
                     */
                    indexOfTheOneAndOblyFaceUpCard = choosenIndex
                }
                cards[choosenIndex].isFaceUp = true
            }
        }
    }
    
    //定义一个计算属性,用来存储 第一张被翻起来的卡片 的索引,用于和 第二张被翻起来的卡片 匹配是否相同
    var indexOfTheOneAndOblyFaceUpCard : Int?{
        //获取面朝上的卡片的索引
        //获取面朝上的卡片的索引
        get{
            //找出卡组中所有面朝上卡片的索引
            /*
             如果只有一张牌面朝上,返回它的索引
             
             如果返回的是nil,表示要么没有面朝上的牌;要么有多张面朝上的牌(即已经有两张牌面朝上,开始第三张牌面朝上的时候)
             返回nil
             */
            cards.indices.filter{cards[$0].isFaceUp == true}.only
        }
        
        set {
            /*
             给此属性赋值的时候,将所有的牌都设置为面朝下,只保留当前卡片面朝上
             因为可能有多张牌面朝上
             */
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    
    struct Card :Equatable,Identifiable,CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "unmathed" )"
        }
        
        var id: String
        
        var isFaceUp = false {   //默认朝下
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false //被翻起过,默认 false
        var isMatched = false   //默认未匹配
        var content : CardContent
    }
    
}


extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}
