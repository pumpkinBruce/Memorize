//
//  CardIfy.swift
//  Memorize
//
//  Created by Bruce on 2025/4/15.
//

import SwiftUI


struct Cardify: ViewModifier {
    
    let isFaceUp : Bool
    
    init( _ isFaceUp: Bool) {
        self.isFaceUp = isFaceUp
    }
    
    func body(content: Content) -> some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)   // 卡片基本形状
            //对 base 进行了多次修改（设置颜色、边框），但它始终是同一个 RoundedRectangle对象。Group只是将这些操作组合在一起，以便将它们应用到同一个视图上。
            base.strokeBorder(lineWidth:Constants.lineWidth)  // 卡片边框
                .background(base.fill(.white))// 卡片背景色（白色）
                .overlay(content)   // 前景是卡片内容
                .opacity(isFaceUp ? 1 : 0)  // 仅当 isFaceUp 为 true 时可见
            base.fill()
                .opacity(isFaceUp ? 0 : 1)   // 仅当 isFaceUp 为 false 时可见
        }
    }
    
    
    /*
     常数,放在结构体底部(每一类数据最好都固定放在某一个位置)
     而上面的 .white,1,0这些数没设置为常数是因为:
        颜色里的黑白,和数字1|0,一般不认为是有真正意义的常数.
     */
    private struct Constants {
        static let cornerRadius : CGFloat  = 12
        static let lineWidth : CGFloat  = 2
        
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp)) //modifier 是 View 的实例属性
    }
}
