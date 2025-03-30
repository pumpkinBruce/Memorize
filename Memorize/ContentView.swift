//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI



/*
    Vesion 3.0
    新增 增删卡片按钮
 */

struct ContentView: View {
    let emojis = ["👻","🎃","🤖","🐼","🐰","🐭","🦊","🐯","🐻","🌸","🐷"]
    @State var cardCount :  Int = 4
    var body: some View {
        //使用数组存储
        
        VStack{
            HStack{
                Text("Memorize")
                Text("得分:")
                
            }
            .font(.largeTitle)
            .padding(.horizontal)
            .foregroundColor(.black)
           
            HStack{
                //.indices 获取数组的索引范围
                ForEach(0..<cardCount,id:\.self) { index in
                    cardView(isFaceUp: true, content: emojis[index])
                }
            }
            
            .foregroundColor(.orange)
            
            HStack{
                
                
                Button(action: {
                    if cardCount > 1 {
                        cardCount -= 1
                    }
                }, label: {
                    Image(systemName: "rectangle.stack.badge.minus.fill")
                })
                //间隔器
                Spacer()
                Button(action: {
                    if cardCount < emojis.count {
                        cardCount += 1
                    }
                }, label: {
                    Image(systemName: "rectangle.stack.badge.plus.fill")
                })

                
               
                
                
            }
            .font(.title)
            .imageScale(.large)
            .foregroundColor(.blue)
        }
        .padding(.all)
        

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
