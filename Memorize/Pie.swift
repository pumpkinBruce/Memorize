//
//  Pie.swift
//  Memorize
//
//  Created by Bruce on 2025/4/14.
//

import SwiftUI
import CoreGraphics

/*
    所有视图（包括 Shape）的坐标系统都是基于 左上角为原点 (0, 0) 的二维坐标系。
 •    原点：左上角 ((0, 0))
 •    X 轴方向：向右为正方向
 •    Y 轴方向：向下为正方向
 
 在 SwiftUI 中“角度增加”会让图形顺时针绕圆转一圈，但因为 y 是向下的，所以视觉上更像数学中的逆时针。
 也就是说: 顺时针和逆时针是颠倒的.
    要实现视觉的顺时针,需要将 clockwise 设为 false
    要实现视觉的逆时针,需要将 clockwise 设为 true

 */

//定义一个扇形Shape(圆的部分),用于制作卡片翻转倒计时动画
struct Pie : Shape {
    
    var startAngle : Angle = .zero  //起始角度
    var endAngle : Angle     //结束角度
    var clockwise = false    //顺时针
    
    
    //rect 是分配的矩形空间
    nonisolated func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        let center = CGPoint(x:rect.midX,y:rect.midY)   //rect 的中心就是扇形的圆心
        let raduis = min (rect.width,rect.height) / 2   // rect 的最短边的一半作为扇形的半径
        let start = CGPoint(
            x: center.x + raduis * cos(startAngle.radians),
            y: center.y + raduis*sin(startAngle.radians)
        )
        
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: raduis,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise,
            )
        p.addLine(to: center)
        
        return p
    }
    
}

#Preview
{
    Pie(endAngle: .degrees(360))
}

