//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI



/*
 1.ContentView:
    因为swift不知道项目是什么,所以swift给了一个默认的项目名 "ContentView",表示这是一个内容视图的结构体

 2. : View
    函数式编程,表示这个contentView的行为表现的像一个试图
    “表现” 意味着 行为 和 功能
    我们专注于功能和行为,而不是数据
 */

struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Memorize")
                Text("得分:")
                
            }
            .font(.largeTitle).padding(.horizontal).foregroundColor(.black)
           
            
            HStack{
                cardView(isFaceUp: true, textValue: "🐷")
                cardView(isFaceUp: true, textValue: "🦅")
                cardView(isFaceUp: true, textValue: "🤖")
                
            }
            HStack{
                cardView(isFaceUp: true, textValue: "🐼")
                cardView(isFaceUp: true, textValue: "🐷")
                cardView(isFaceUp: true, textValue: "🐻")
                
            }
            HStack{
                cardView(isFaceUp: true, textValue: "🦅")
                cardView(isFaceUp: true, textValue: "🤖")
                cardView(isFaceUp: true, textValue: "🐻")
                
            }
        }
        .padding(.all)
        .foregroundColor(.orange)

    }
}


//卡片视图
struct cardView : View {
    @State var isFaceUp : Bool
    var textValue : String
    
    
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
                Text(textValue).font(.largeTitle)
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
