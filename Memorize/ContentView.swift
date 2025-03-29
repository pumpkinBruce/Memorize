//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
 View Builder 视图构建器
 
    ViewBuilder 是一个 SwiftUI 的属性包装器，用于将多个 View 组合成一个View。
    可以理解为：像搭积木一样，将多个独立视图按照规则组合成一个完整的积木整体。
 
 规则与限制

 在 ViewBuilder 代码块中，你只能：
 ✅ 列出视图（即直接返回多个视图）。
 ✅ 做条件判断（如 if、switch）。
 ✅ 声明局部变量（如 let 但不能 var ）。

 但不能：
 ❌ 使用 for 循环（必须用 ForEach 代替）。
 ❌ 使用 return 关键字（隐式返回）。
 ❌ 进行赋值语句（如 var sum = 0）。
 
 常见ViewBuilder
 
 VStack 垂直堆叠             将多个视图垂直排列（从上到下）。
 HStack（水平堆叠）           将多个视图水平排列（从左到右）。
 ZStack（层叠视图）           将多个视图重叠在一起，后面的视图会覆盖前面的视图。
 List（列表视图）             用于创建可滚动列表，适用于展示大量数据。
 Section（用于 List 的分组）   在 List 里添加分区标题。
 LazyVStack & LazyHStack（惰性加载）  适用于大量数据的情况，仅在需要时加载视图，提高性能。
 ForEach（循环生成视图）        用于动态创建多个视图，通常与 List 或 ScrollView 搭配使用。
 Group（分组但不影响布局）        将多个视图归为一组，但不会影响视图的布局。
 ScrollView（滚动视图）       使视图可滚动，支持水平或垂直方向。

 
 */

struct ContentView: View {
    var body: some View {

        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            base.foregroundColor(.white)
            base.strokeBorder(lineWidth:9)
    //               .strokeBorder(style:StrokeStyle(lineWidth:9,dash: [10,1]))x
            Text("👻").font(.largeTitle)
        }
        /*
         当在 视图构造器（如 ZStack）上添加 视图修饰器 时，该修饰器会对其包含的所有子视图应用默认样式。
         如果子视图自身也使用了相同类型的修饰器，则子视图的修饰器优先级更高，覆盖外层修饰器的效果。
         
         如果子视图不支持某一类型的修饰器,自动忽略视图构造器上的那一项修饰器.
         
         结论
             • 外层（ZStack）的修饰器会默认影响所有子视图。
             • 子视图的同类型修饰器优先级更高，可以覆盖外层的效果。
        */
        .padding(.all)
        .foregroundColor(.orange)

    }
}


#Preview {
    ContentView() 
}
