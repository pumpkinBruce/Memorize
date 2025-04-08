//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
    Vesion 3.3
    1.使用 .animation 修饰器添加洗牌动画
    2.编写翻转卡片的逻辑.(注意结构体是值类型通过View 层层传递到 Model 的card都是副本)
    3.编写卡片匹配逻辑
 */

struct EmojiMemoryGameView: View {
    
    //ObservedObject: 观察ViewModel,如果这个东西表明有什么发生改变,就重新绘制
    @ObservedObject var viewModel : EmojiMemorizeGame
    
    var body: some View {
        VStack{
            
            ScrollView{
                cards
                //当value 发生改变,执行动画.因此要求 value 遵循 Equatable 协议来保证可以判断是否相等
                    .animation(.default,value: viewModel.cards)
            }
            
            Button("洗牌"){
                viewModel.shuffle()
            }
        }
        .padding(.all)
            
    }
    
    var cards : some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85 ),spacing: 0)],spacing: 0){
            let emojis = viewModel.cards
            /*
             为了点击洗牌后,可以有卡片移动的动画
             我们在 foreach 卡片数组的时候,不再关联索引,而是关联卡片本身.
             因此 卡片在数组中移动的时候,动画也跟着移动
             */
            ForEach(emojis) { card in
//                ForEach(emojis.indices,id : \.self) { index in
                cardView(card)
                .aspectRatio(2/3, contentMode: .fit)
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



