# Lecture 6

Layout, @ViewBuilder


## 概述

SwiftUI 如何在有限的资源下布局视图？我们又该如何创建自己的“布局引擎”视图？更新 Memorize，使其卡片布局更加高效。

layout
    SwiftUI 如何将空间分配给 View? 
    (SwiftUI 如何在有限的空间中,为我们的 View 选择合适的尺寸)
    
@ViewBuilder
    @ViewBuilder 工作原理
    手写一个AspectVGrid

## 一.layout
    SwiftUI 如何将空间分配给 View? 
    (SwiftUI 如何在有限的空间中,为我们的 View 选择合适的尺寸)





### GeometryReader
GeometryReader 是一个容器视图，它把它所包含的内容包装起来，并在其闭包中提供一个 GeometryProxy 对象，你可以通过这个对象获取当前视图的布局信息。

code:
GeometryReader { geometry in
    // 这里你可以使用 geometry 提供的尺寸信息
    Text("宽度: \(geometry.size.width)")
}

•    geometry.size：当前视图的尺寸（宽度和高度）。
•    geometry.frame(in: .global)：视图在整个屏幕中的位置。
•    geometry.frame(in: .local)：视图在自己父视图坐标系中的位置。


特点
🧱具有灵活尺寸: GeometryReader 默认会 **占满父视图能给它的所有空间**，就像 Spacer() 一样。
🔧常用来适配布局:    根据不同设备大小/比例动态调整子视图的排布。
📏 尺寸信息源:  GeometryReader 不直接控制子视图布局，但**能提供关键的布局信息**让你“有条件地布局”。




因为它会占据所有可用空间，如果你不希望它“爆开”，建议包裹在一个有尺寸限制的容器中，比如：

VStack {
    GeometryReader { geometry in
        Text("宽度: \(geometry.size.width)")
    }
    .frame(height: 100) // 限制高度
}



## 二.ViewBuilder

我们为什么需要 ViewBuilder?
    很多时候,我们需要将多个 View 像搭建乐高一样组合成一个 View 传递出去.
    ViewBuilder 可以将多个 View 包装成一个 View.

需要一个返回 View 的函数




# Lecture 7

##shape



##animation

制作动画的方式有两种:
    1.通过形状(shape)变化
    2.viewModifier








