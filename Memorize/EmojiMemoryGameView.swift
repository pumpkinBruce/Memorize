//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
    Vesion 3.5
    lecture
    1.将 CardView 作为单独的一个 View 文件
    2.使用 typealias(类型别名) 简化冗余的 MemorizeGame<String>.Card
    3.使用常量代替“蓝色数字”,定义私有结构体常量(CardView)
    4.定义一个shape: Pie 作为倒计时动画的 View
    6.定义一个modifier: Cardify,将将一个 Pie和卡片内容 的视图包装为一个卡片.并实现翻转动画
    7.cardify中,使用 .backgroud .overlay 优化生成卡片的代码
    8.将cardify扩展成为View协议的一个修饰器
    
 */

struct EmojiMemoryGameView: View {
    
    //ObservedObject: 观察ViewModel,如果这个东西表明有什么发生改变,就重新绘制
    @ObservedObject var viewModel : EmojiMemorizeGame
    
    private let cardAspectRatio : CGFloat = 2 / 3 //单张卡片宽高比. 此值固定,所以设为常量
    private let spacing : CGFloat = 4 //间距
    
    /*
     在cards 属性上加了一个 "@ViewBuilder" 使得可以查看 cards 里面的内容,那可以加在这里吗?
     apple 的开发者已经为我们完成了这项工作
     这里隐式的存在一个"@ViewBuilder"
     */
    var body: some View {   //body 是view协议的一部分,是公开的,所以不设为 private
        VStack{
            //当value 发生改变,执行动画.因此要求 value 遵循 Equatable 协议来保证可以判断是否相等
            cards
            .animation(.default,value: viewModel.cards)
            .foregroundColor(viewModel.color)
            
            Button("洗牌"){
                viewModel.shuffle()
            }
        }
        .padding(.all)
    }
    
    private var cards : some View{
        AspectVGrid(viewModel.cards, aspectRatio : cardAspectRatio) { card in
            //我可能在传递的函数中执行 if-then,所以我应该在AspectVGrid 的构造函数中接受ViewBuilder.否则我需要加 return 才能传递.
            CardView(card)
                .padding(spacing)
                .onTapGesture { //通过点击修饰器来实现翻转卡片
                    viewModel.choose(card)
                }
        }
    }
    
}

#Preview
{
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame() )
}



