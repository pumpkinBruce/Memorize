//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Bruce on 2025/3/16.
//

import SwiftUI

@main
struct MemorizeApp: App {
    /*
     @StateObject 状态对象
     用于创建并且管理一个实例
    如果你在 多个地方使用 @StateObject 创建同一个对象，可能会导致重复初始化和 UI 状态丢失。
    在应用层可以使用 @StateObject 创建并持有 ViewModel,因为不会有更高的层级.
    */
    
    @StateObject var game = EmojiMemorizeGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
