//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
    Vesion 4
    lecture 8
    1.新增得分功能
    2.3D翻转卡片
    3.新增卡片内容匹配后旋转动画
    4.在合适的位置使用隐式动画 .animation 来自定义单个View的动画或者关闭动画
 */

struct EmojiMemoryGameView: View {
    
    typealias Card = MemorizeGame<String>.Card
    
    //ObservedObject: 观察ViewModel,如果这个东西表明有什么发生改变,就重新绘制
    @ObservedObject var viewModel : EmojiMemorizeGame
    
    private let cardAspectRatio : CGFloat = 2 / 3 //单张卡片宽高比. 此值固定,所以设为常量
    private let spacing : CGFloat = 4 //间距
    
    /*
     在cards 属性上加了一个 "@ViewBuilder" 使得可以查看 cards 里面的内容,那可以加在body这里吗?
     apple 的开发者已经为我们完成了这项工作
     这里隐式的存在一个"@ViewBuilder"
     */
    var body: some View {   //body 是view协议的一部分,是公开的,所以不设为 private
        VStack{
            //当value 发生改变,执行动画.因此要求 value 遵循 Equatable 协议来保证可以判断是否相等
            cards
                .foregroundColor(viewModel.color)
            HStack{
                score
                Spacer()
                shuffle
            }
        }
        .padding(.all)
    }



    private var score : some View {
        Text("得分\(viewModel.score)")
            .font(.largeTitle)
            .animation(nil) //我们希望得分不要有动画,使用隐式动画 .animation(.nil)修饰符,表示零动画
    }
    
    private var shuffle : some View {
        Button("洗牌"){
            //显示动画
            withAnimation {  //使用默认动画即可
                viewModel.shuffle()
            }
        }
    }

    
    private var cards : some View{
        AspectVGrid(viewModel.cards, aspectRatio : cardAspectRatio) { card in
            //我可能在传递的函数中执行 if-then,所以我应该在AspectVGrid 的构造函数中接受ViewBuilder.否则我需要加 return 才能传递.
            CardView(card)
                .padding(spacing)
                .overlay{
                    
                }
                .onTapGesture {
                    //点击卡片,动画化所有发生的事情(包括得分)
                    withAnimation{  //默认 easeInOut
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    
    
}

#Preview
{
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame() )
}



