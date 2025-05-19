//
//  CardView.swift
//  Memorize
//
//  Created by Bruce on 2025/4/14.
//

import SwiftUI



//卡片视图 定义了卡片的外观
struct CardView : View {
    
    
    typealias Card = MemorizeGame<String>.Card
    
    let card : Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    
    var body : some View{
        Pie(endAngle: Angle.degrees(270) )
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest)) // 显示内容（文本）
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)    //最小比例因子,如果文字内容过大,会缩小到其大小 0.05
                    .multilineTextAlignment(.center)    //多行文本对齐
                    .aspectRatio(1,contentMode: .fit)   //设置内容的宽长比为1:1,
                    .padding(Constants.Pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0)) //旋转
                    .animation(.spin(duration: 1), value: card.isMatched)   //控制旋转的速度和重复,隐式动画不会被显示动画影响.
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isMatched ? 0 : 1)

    }


    /*
     常数,放在结构体底部(每一类数据最好都固定放在某一个位置)
     而上面的 .white,1,0这些数没设置为常数是因为:
        颜色里的黑白,和数字1|0,一般不认为是有真正意义的常数.
     */
    private struct Constants {
        static let inset : CGFloat  = 5
        
        struct FontSize {
            static let largest : CGFloat  = 200
            static let smallest : CGFloat  = 10
            static let scaleFactor   = smallest / largest   //用于文字比例因子
        }
        
        struct Pie {
            static let opacity : CGFloat  = 0.5
            static let inset : CGFloat  = 5
        }
    }
}

//扩展动画:卡片配对,图案旋转动画
extension Animation {
    static func spin (duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}


//预览
struct CardViewPreviews: PreviewProvider {
    //在 CardView 结构体中给 MemorizeGame<String>.Card 类型起了别名,所以这里可以这么写.
    typealias Card = CardView.Card
    
    static var previews: some View{
        VStack{
            HStack {
                CardView(Card(id: "t1", content: "X") )
                    .padding()
                    .aspectRatio(4/3, contentMode: .fit)
                CardView(Card(id: "t2", isFaceUp: true, content: "X") )
                    .padding()
                    .padding(.top)
            }
            HStack {
                CardView(Card(id: "t1", content: "X") )
                    .padding()
                CardView(Card(id: "t1", content: "X") )
                    .padding()
                CardView(Card(id: "t2", isFaceUp: true, content: "X") )
                    .padding()
                    
            }
        }
        .foregroundColor(.blue)

        
    }
}



