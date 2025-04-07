//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
    Vesion 3.2
    1. 使用 MVVM 架构分离 model View ViewModel
    2.设置 model 中属性的访问权限
    3.控制 ViewModel 中静态属性和静态方法的访问权限.(因为他们负责静态的创建实例,最好对外不可见)
    4. 在 ViewModel 中使用 @oublished 包装 model 属性.使它可以被观察,以便可以实时刷新UI.
    5.@ObservedObject 和 @State @StateObject 的使用
    
 */

struct EmojiMemoryGameView: View {
    
    //@ObservedObject 观察对象
    //ObservedObject: 观察ViewModel,如果这个东西表明有什么发生改变,就重新绘制
    //观察对象不能被直接赋值.只能被传递给到.因为观察对象必须被标记为“实时的状态”
    @ObservedObject var viewModel : EmojiMemorizeGame
    
    var body: some View {
        VStack{
            /*
             卡片宽:高 为 2 : 3 后,添加卡片会导致 增删 卡片的按钮被挤出屏幕.
             使用ScrollView 滚动视图.
             */
            ScrollView{
                cards
            }
            Button("打乱顺序"){
                viewModel.shuffle()
            }
        }
        .padding(.all)
            
    }
    
    var cards : some View{
        //LazyVGrid 网格 懒加载（Lazy）垂直网格（Vertical Grid）布局容器
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85 ),spacing: 0)],spacing: 0){    //.adaptive()自适应屏幕
            let emojis = viewModel.cards
            ForEach(emojis.indices,id:\.self) { index in
                cardView(emojis[index])
                .aspectRatio(2/3, contentMode: .fit)
                .padding(4)
                /*
                 上面这行代码是使得卡片的宽:长比例为 2 : 3 更符合现实中的卡片.
                 */
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

            /*
            Group 是 SwiftUI 的一种视图容器，用于将多个视图组合在一起，但不会影响布局。   只是逻辑上的分组。
             */
            Group {
                base.foregroundColor(.white)    // 背景色（白色）
                base.strokeBorder(lineWidth:2)  // 卡片边框
                Text(card.content)
                    .font(.system(size: 200)) // 显示内容（文本）
                    .minimumScaleFactor(0.01)   //最小比例因子,如果文字内容过大,会缩小到其大小 1/100
                    .aspectRatio(1,contentMode: .fit)   //设置内容的宽长比为1:1,
            }
            .opacity(card.isFaceUp ? 1 : 0)  // 仅当 isFaceUp 为 true 时可见
            base.fill().opacity(card.isFaceUp ? 0 : 1)   // 仅当 isFaceUp 为 false 时可见
        }
    }
}

#Preview
{
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame() )
}



