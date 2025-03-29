//
//  ContentView.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI


/*
 Memorize 使用函数式编程
 
 函数式编程
 
 behaves like a...  表现得像一个...
 “表现” 意味着 行为 和 功能
 函数式编程强调的是行为.
 
 函数式编程和面向对象编程的区别:
    面向对象的根源是数据封装.
    函数式编程在描述其功能时,不会使用“数据”这个词,更多的是行为封装,描述的是这个结构体会如何运作,运行.而不是数据会如何处理.
    函数式编程专注于行为和功能,而不是数据.
 */



/*
 1.ContentView:
    因为swift不知道这个项目是用来做什么,所以swift给了一个默认的项目名 "ContentView",表示这是一个叫做“内容视图”的结构体.(因为他遵循View协议)

 2. : View
    协议导向编程
    表示这个contentView的行为表现的像一个视图.
    “表现” 意味着 行为 和 功能.这就是函数式编程.
 
    表现的像一个View:(这就像一把双刃剑,一方面,你必须做点什么满足他的条件;另一方面,你只要满足这个要求,你就可以获得View所能做的所有功能)
        要求struct内部存在一个body属性.
        满足这个要求之后,可以使用View的所有的功能.
    
 3.var body : some View
    一个视图可能由多个其他的视图构成,所以body属性的类型为 some View(范型的思想)
    body的内容是一些列的View,具体是什么View?多少个View?不清楚.
    只有到编译的时候才知道是具体的什么View.并且swift会自动替换为具体的View类型.
 
 4. .padding(.all)
    对 Text() 这个View进行修饰,所以我们把一个视图后续的“.XX()”称为视图修饰器.(View Modifier).
    经过修饰后的视图就不再是原视图本身.会成为一个新的类型.所以这也是使用some View来表示body的类型的原因.
    
    
 */
struct ContentView: View {
    var body : some View{   //此案例中,编译后自动替换为对应的类型.如果直接使用 Text,会报错.
//        Text("Hello,World!")
        Text("Hello,World!").padding()
    }
    
}


#Preview {
    ContentView() 
}
