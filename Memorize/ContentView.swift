//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI



/*
    Vesion 3.1
    1.(line29)将视图代码语逻辑代码分离.增加可读性.
    2.(line 71)使用一个通用函数 cardCountAdjuster,封装按钮的逻辑。
    3.(line77)cardCountAdjuster 中,为了保证增加/移除卡片的合法性(可能超出emojis 数组范围),使用 .disabled 修饰器 在超出范围是禁用按钮.
    4.(line38)HStack 是 单行水平排列，当卡片数量过多时，会超出屏幕宽度，导致卡片被压缩成细长条，影响 UI 体验。
    使用 LazyVGrid 视图,懒加载的垂直网格容器.
    LazyVGrid 支持多行排列，会在每行放入合适数量的卡片，不会出现卡片挤压变形的情况。
    在 LazyVGrid 中定义每行多少个元素时使用 adaptive() 修饰器,可以根据屏幕自适应布局.
 */

struct ContentView: View {
    let emojis = ["👻","🎃","🤖","🐼","🐰","🐭","🦊","🐯","🐻","🌸","🐷"]
    @State var cardCount :  Int = 4
    @State var isOn :  Bool = true
    var body: some View {
        //将视图代码的具体逻辑拆分为后面的 cards, cardRemover, cardAdder 变量
        VStack{
            cards
            Spacer()
            cardCountAdjusters
        }.padding(.all)
    }
    
    var cards : some View{
        //LazyVGrid 网格 懒加载（Lazy）垂直网格（Vertical Grid）布局容器
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){    //.adaptive()自适应屏幕
//        LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]){
            /*
                HStack 是 单行水平排列，当卡片数量过多时，会超出屏幕宽度，
                导致卡片 被压缩成细长条，影响 UI 体验。
                ,使用 LazyVGrid 来优化显示
            */
            //HStack{
            //.indices 获取数组的索引范围
            ForEach(0..<cardCount,id:\.self) { index in
                cardView(isFaceUp: true, content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters : some View {
        HStack{
            cardRemover
            //间隔器
            Spacer()
            cardAdder
        }
        .font(.title)
        .imageScale(.large)
    }
    
    /*
     由于 cardRemover 和 cardAdder 的按钮代码几乎相同，
         为了减少重复代码，提高代码的简洁性和可维护性，
         我们创建了一个通用函数 cardCountAdjuster，
         用于封装按钮的逻辑。
     */
    func cardCountAdjuster (by offset : Int, symbol : String) -> some View{
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
        /*
         上面这行代码的作用是:
         目前是通过一个数组存储的卡片图案
         为了保证增删卡片的时候,不能越过数组的下标范围
         使用 disabled 视图修饰器
         */
    }
    
    var cardRemover : some View{
        return cardCountAdjuster(by: -1,symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder : some View{
        return cardCountAdjuster(by: 1,symbol: "rectangle.stack.badge.plus.fill")
    }
    
}


//卡片视图
struct cardView : View {
    @State var isFaceUp : Bool
    let content : String
    
    var body : some View{
        /*View Builder 视图构建器
         自动将多个 View 组合成一个 View.(有点像是将多个积木按照规则处理为一个完整积木)
         ViewBuilder 只能列出视图、做条件判断和声明局部变量.它不允许 for 语句、赋值语句、return 关键字等
         */
        
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            if isFaceUp{
                base.foregroundColor(.white)
                base
//                    .stroke(lineWidth: 10)
                    .strokeBorder(lineWidth:9)
    //                .strokeBorder(style:StrokeStyle(lineWidth:9,dash: [10,1]))x
                Text(content).font(.largeTitle)
            }else{
                base.fill()
            
            }
            
        }.onTapGesture {  //点击手势修饰符
            print("卡片被点击")
//            isFaceUp = !isFaceUp
            //swift中切换布尔值的方法:.toggle()
            isFaceUp.toggle()
        }
        
    }
}

#Preview {
    ContentView() 
}



