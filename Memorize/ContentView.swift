//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI



/*
    Vesion 3.2
    1.(line29)使用.opacity() 修饰器,控制卡片 正反面的透明度实现正反的翻转
    2.(126)使用 ScrollView 布局视图,实现多卡片时滚动效果
 */

struct ContentView: View {
    let emojis = ["👻","🎃","🤖","🐼","🐰","🐭","🦊","🐯","🐻","🌸","🐷"]
    @State var cardCount :  Int = 4
    @State var isOn :  Bool = true
    var body: some View {
        //将视图代码的具体逻辑拆分为后面的 cards, cardRemover, cardAdder 变量
        VStack{
            /*
             保证卡片宽:高 为 2 : 3后,添加卡片会导致增删 卡片的按钮被挤出屏幕.
             使用ScrollView 滚动视图.
             */
            ScrollView{
                cards
            }
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
                    .aspectRatio(2/3, contentMode: .fit)
                /*
                 上面这行代码是使得卡片的宽:长比例为 2 : 3 更符合现实中的卡片.
                 */
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
            /*
             SwiftUI 视图尺寸默认是基于内容的，如果 isFaceUp == false，Text 被移除，SwiftUI 重新计算大小，导致卡片变小。
             当所有卡片都面朝下，内容消失，导致 SwiftUI 重新计算适合的大小，缩小了卡片的尺寸。
             */
            let base = RoundedRectangle(cornerRadius: 10)
//            if isFaceUp{
//                base.foregroundColor(.white)
//                base.strokeBorder(lineWidth:9)
//                Text(content).font(.largeTitle)
//            }else{
//                base.fill()
//            
//            }
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth:9)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
            
        }.onTapGesture {  //点击手势修饰符
            print("卡片被点击")
            //swift中切换布尔值的方法:.toggle()
            isFaceUp.toggle()
        }
        
    }
}

#Preview {
    ContentView() 
}



