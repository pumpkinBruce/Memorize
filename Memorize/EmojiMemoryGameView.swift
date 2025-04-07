//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
    Vesion 3.2
    
 */

struct EmojiMemoryGameView: View {
    
    var viewModel : EmojiMemorizeGame = EmojiMemorizeGame()
    
    let emojis = ["👻","🎃","🤖","🐼","🐰","🐭","🦊","🐯","🐻","🌸","🐷"]
    
    var body: some View {
        /*
        卡片宽:高 为 2 : 3 后,添加卡片会导致 增删 卡片的按钮被挤出屏幕.
        使用ScrollView 滚动视图.
        */
        ScrollView{
            cards
        }
        .padding(.all)
    }
    
    var cards : some View{
        //LazyVGrid 网格 懒加载（Lazy）垂直网格（Vertical Grid）布局容器
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){    //.adaptive()自适应屏幕
            ForEach(emojis.indices,id:\.self) { index in
                cardView(isFaceUp: true, content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
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
    @State var isFaceUp : Bool  // 控制卡片是否朝上
    let content : String    // 卡片内容（如 emoji）
    
    var body : some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)   // 卡片基本形状

            /*
            Group 是 SwiftUI 的一种视图容器，用于将多个视图组合在一起，但不会影响布局。   只是逻辑上的分组。
             */
            Group {
                base.foregroundColor(.white)    // 背景色（白色）
                base.strokeBorder(lineWidth:9)  // 卡片边框
                Text(content).font(.largeTitle) // 显示内容（文本）
            }
            .opacity(isFaceUp ? 1 : 0)  // 仅当 isFaceUp 为 true 时可见
            base.fill().opacity(isFaceUp ? 0 : 1)   // 仅当 isFaceUp 为 false 时可见
        }.onTapGesture {  //点击手势修饰符
            print("卡片被点击")
            //swift中切换布尔值的方法:.toggle()
            isFaceUp.toggle()  // 切换卡片的正反面
        }
    }
}

#Preview {
    EmojiMemoryGameView() 
}



