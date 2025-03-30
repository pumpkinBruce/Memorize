//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
常用视图:

1.基础视图:
Text 显示文字
Image 显示图片
Label 结合图标和文字

2.交互控件

Button 按钮 (触发动作)
Toggle 开关 (绑定布尔值)
TextField 文本输入框
Slider 滑动条(绑定数值)

3.绘图与形状

Rectangle/Circle/RoundedRectangle   绘制基础形状(矩形/圆/圆角矩形)

4.列表

Lisi 列表
scrollView 包裹内容实现滚动
ForEach 根据集合动态生成视图


5.布局容器  (用于管理子视图的排列方式)
VStack 垂直堆叠子视图
HStack 水平堆叠子视图
ZStack 面向用户,层叠子视图(后添加的在上层)
lazyVStack/lazyHStack   惰性加载堆叠容器,仅渲染可见区域的子视图.
spacer 占据剩余空间,用于撑开布局.
Divider 添加一条分割线.
...

当视图需要组合多个子视图时,SwiftUI 使用 @ViewBuilder 简化代码.
比如:
        VStack{
            Text("line1")
            Text("line2")
            Image(systemName: "globe")
        }
这里的{...} 时 @ViewBuilder 闭包,他会将多个子视图组成一个视图层级.


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
