//
//  CardIfy.swift
//  Memorize
//
//  Created by Bruce on 2025/4/15.
//

import SwiftUI


struct Cardify: ViewModifier, Animatable {
    
    init (isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    //小于90度,则是正面
    var isFaceUp : Bool {
        rotation < 90
    }
    
    var rotation : Double
    
    //我们希望牌在翻过90度之后才能看到卡片内容(或者翻过90度才看不到卡片内容),使用 animatableData 来控制
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
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
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))  //为卡片翻转制作翻转动画,这是属于cardify(制作卡片)的功能
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
        modifier(Cardify(isFaceUp: isFaceUp)) //modifier 是 View 的实例属性
    }
}
