//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anderson  on 2023/8/15.
//

import SwiftUI

@main
struct MemorizeApp: App {
	@StateObject private var game = EmojiMemoryGame()
	var body: some Scene {
		WindowGroup {
			EmojiMemoryGameView(emojiMemoryGame: game)
		}
	}
}
