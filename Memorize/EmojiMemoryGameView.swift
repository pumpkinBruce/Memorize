//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

/*
    Vesion 3.4
    lecture 6 layout and ViewBuilder 原理解析
    1.LazyVGrid 的原理介绍
    2.使用 GeometryReader 代替 ScrollView 实现在给定空间内根据卡片数量自适应大小
    3.使用 @ViewBuilder 修饰 cards 计算属性,使其被解释为 ViewBuilder
    
 */

struct EmojiMemoryGameView: View {
    
    //ObservedObject: 观察ViewModel,如果这个东西表明有什么发生改变,就重新绘制
    @ObservedObject var viewModel : EmojiMemorizeGame
    
    private let cardAspectRatio : CGFloat = 2 / 3 //单张卡片宽高比. 此值固定,所以设为常量
    
    /*
     在cards 属性上加了一个 "@ViewBuilder" 使得可以查看 cards 里面的内容,那可以加在这里吗?
     apple 的开发者已经为我们完成了这项工作
     这里隐式的存在一个"@ViewBuilder"
     */
    var body: some View {   //body 是view协议的一部分,是公开的,所以不设为 private
        VStack{
            //当value 发生改变,执行动画.因此要求 value 遵循 Equatable 协议来保证可以判断是否相等
            cards
            .animation(.default,value: viewModel.cards)
            
            
            Button("洗牌"){
                viewModel.shuffle()
            }
        }
        .padding(.all)
    }
    
    
    /*
     cards 是用来构建卡片组的
     所以我们可以使用 @ViewBuilder 表示可以查看计算属性的内容,就像他是一个 ViewBuilder 一样
     这样可以将一个函数 或者 计算属性解释为一个 ViewBuilder. 那么里面的值就不必使用return.可以直接访问查看
     */
    @ViewBuilder
    private var cards : some View{  //通常,我们将所有的属性 方法都设为private,除非不需要私有才设为默认公开.
        //let atAspectRatio : CGFloat = 2/3 //卡片宽高比. 此值固定,所以设为常量  这个常量比较重要且可能不止这个作用域使用,可以放到外面
        /*
         我希望卡片多的时候,每张卡片可以变小一点,卡片少的时候,我希望每一张卡片变大.
         使用 GeometryReader 来实现
         GeometryReader 是一个容器视图，,它把它所包含的内容包装起来成为一个视图，并在其闭包中提供一个 GeometryProxy 对象，
         你可以通过这个对象获取当前整个视图的布局信息。(整个View 的 宽长信息....)
         
         
         */
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: cardAspectRatio)
            /*
             columns:[GridItem]
             定义有多少列,并且对每一列进行控制.所以 columns 的类型是一个 [GridItem] 数组
             可以在 GridItem() 实例中进行调试每一列元素.
             GridItem()中默认参数为: GridItem(.flexible()) 表示 网格单元 是灵活视图
             也可以 GridItem(.fixed(100)) 表示将网格单元固定为100大小
             
             GridItem中的 spacing: CGFloat 定义一行中每个网格单元的间距(列间距)
             最好设置为 0
             LazyVGrid中的 spacing: CGFloat 定义行间距
             最好设置为 0
             
             行列间距的组合即是: 空间间距
             最好都设置为0 因为
             我们的目标是选择合适的尺寸卡片,去掉 space 这个因素(即设为0)
             行间距取决于设备平台,Watch iPhone Mac 的行间距可能不同.
             因此无法预测在不同设备展示的样子. 所以我们设置为0,再选择空间,保证他们可以适应.
             我们可以在后面的卡片的.padding修饰器来控制 间距.
             因为使用 .padding 的时候,已经划分好了空间以适应正确数量的卡片
             */
            //        LazyVGrid(columns: [GridItem(.flexible(),spacing: 0)],spacing: 0){
            
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize),spacing: 0)],spacing: 0){
                /*
                 为了点击洗牌后,可以有卡片移动的动画
                 我们在 foreach 卡片数组的时候,不再关联索引,而是关联卡片本身.
                 因此 卡片在数组中移动的时候,动画也跟着移动
                 */
                ForEach(viewModel.cards) { card in
                    //                ForEach(emojis.indices,id : \.self) { index in
                    cardView(card)
                        .aspectRatio(cardAspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture { //通过点击修饰器来实现翻转卡片
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.orange)
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

//卡片视图 定义了卡片的外观
struct cardView : View {
    
    let card : MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body : some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)   // 卡片基本形状

            Group {
                Group {
                    //对 base 进行了多次修改（设置颜色、边框），但它始终是同一个 RoundedRectangle 对象。Group 只是将这些操作组合在一起，以便将它们应用到同一个视图上。 
                    base.foregroundColor(.white)   // 背景色（白色）
                    base.strokeBorder(lineWidth:2)  // 卡片边框
                    Text(card.content)
                        .font(.system(size: 200)) // 显示内容（文本）
                        .minimumScaleFactor(0.01)   //最小比例因子,如果文字内容过大,会缩小到其大小 1/100
                        .aspectRatio(1,contentMode: .fit)   //设置内容的宽长比为1:1,
                }
                .opacity(card.isFaceUp ? 1 : 0)  // 仅当 isFaceUp 为 true 时可见
                base.fill()
                    .opacity(card.isFaceUp ? 0 : 1)   // 仅当 isFaceUp 为 false 时可见
            }.opacity(card.isMatched ? 0 : 1)
        }
    }
}

#Preview
{
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame() )
}



