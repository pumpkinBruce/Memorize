//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
    Vesion 3.4.1
    lecture 6 layout and ViewBuilder 原理解析
    1.自定义 AspectVGrid:
        容器视图，用于以“特定宽高比”在垂直方向上自动排列一组视图项，呈现为自适应网格布局（类似 LazyVGrid，但更智能地控制尺寸）。
    2.@ViewBuilder 可以标记在计算属性,函数,函数的参数上
    
 */

struct EmojiMemoryGameView: View {
    
    //ObservedObject: 观察ViewModel,如果这个东西表明有什么发生改变,就重新绘制
    @ObservedObject var viewModel : EmojiMemorizeGame
    
    private let cardAspectRatio : CGFloat = 2 / 3 //单张卡片宽高比. 此值固定,所以设为常量
    
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
            
            Button("洗牌"){
                viewModel.shuffle()
            }
        }
        .padding(.all)
    }
    
    private var cards : some View{
        AspectVGrid(viewModel.cards, aspectRatio : cardAspectRatio) { card in
            //我可能在传递的函数中执行 if-then,所以我应该在AspectVGrid 的构造函数中接受ViewBuilder.否则我需要加 return 才能传递.
            VStack{
                cardView(card)
                    .padding(4)
                    .onTapGesture { //通过点击修饰器来实现翻转卡片
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
    
    
    
}

//卡片视图 定义了卡片的外观
struct cardView : View {
    
    let card : MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body : some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)   // 卡片基本形状

            Group {
                Group {
                    //对 base 进行了多次修改（设置颜色、边框），但它始终是同一个 RoundedRectangle 对象。Group 只是将这些操作组合在一起，以便将它们应用到同一个视图上。 
                    base.foregroundColor(.white)   // 背景色（白色）
                    base.strokeBorder(lineWidth:2)  // 卡片边框
                    Text(card.content)
                        .font(.system(size: 200)) // 显示内容（文本）
                        .minimumScaleFactor(0.01)   //最小比例因子,如果文字内容过大,会缩小到其大小 1/100
                        .aspectRatio(1,contentMode: .fit)   //设置内容的宽长比为1:1,
                }
                .opacity(card.isFaceUp ? 1 : 0)  // 仅当 isFaceUp 为 true 时可见
                base.fill()
                    .opacity(card.isFaceUp ? 0 : 1)   // 仅当 isFaceUp 为 false 时可见
            }.opacity(card.isMatched ? 0 : 1)
        }
    }
}

#Preview
{
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame() )
}



