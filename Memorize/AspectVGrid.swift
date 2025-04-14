//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Bruce on 2025/4/11.
//

import SwiftUI


/*
    AspectVGrid 自定义容器视图
    作用是:
    用于以网格形式布局一组具有特定宽高比的视图项。
    它能够根据 可用空间 和 视图项的数量，自动调整每个视图项的大小，以尽可能地填充整个网格区域。
 */
//范型 可以布局任何类型的数组
struct AspectVGrid<Item : Identifiable, ItemView: View>: View {
    
    private var items : [Item]
    private var aspectRatio : CGFloat = 1   //默认宽长比 = 1
    private var content :  (Item) -> ItemView
     
    /*
     如果你希望传入的content 是一个ViewBuilder,可以在参数前面加 @ViewBuilder.
     这时候,属性content 前面就可以不用加 @ViewBuilder 了
     因为 init 执行,编译器就已经知道 content 属性将包含一个由 ViewBuilder 处理过的 View。
     content 属性存储的是一个已经构建好的 View，而不是一个需要被构建的ViewBuilder.
     因此，你不需要在属性 content 前再次添加 @ViewBuilder。
    
    */
    
    init(_ items: [Item], aspectRatio: CGFloat,@ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize),spacing: 0)],spacing: 0){
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
        
        
        
    }
    
    
    /*
     gridItemWidthThatFits 用于确认设置单个卡片宽度
     count : 放多少张卡片?
     size: 分配给 GeometryReader 的空间
     atAspectRatio : 卡片的宽高比
     */
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio: CGFloat) -> CGFloat{
            let count = CGFloat(count)
            var columnCount = 1.0 //列数量(即每一行多少个) 为了保证我的卡片尽可能大,先尝试一列.看空间是否可以容下所有卡片,不行再加1
            repeat{
                let width = size.width / columnCount  //单个 view 的宽度
                let height = width / atAspectRatio   //单个 view 的高度
                let rowCount = (count / columnCount).rounded(.up)   //行的数量
                
                if (rowCount * height) < size.height {
                    return (size.width / columnCount).rounded(.down)
                }
                columnCount += 1
            } while columnCount < count
            return min(size.width / count, size.height * atAspectRatio).rounded(.down)
    }
}

