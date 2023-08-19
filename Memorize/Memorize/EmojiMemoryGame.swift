//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anderson  on 2023/8/16.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
	private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
	
	private static func createMemoryGame() -> MemoryGame<String> {
		MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
			if emojis.indices.contains(pairIndex) {
				return emojis[pairIndex]
			}
			return "🧨"
		}
	}
	
	@Published private var game = createMemoryGame()
	
	var cards: [MemoryGame<String>.Card] { game.cards }
	
	// MARK: - Indents
	
	func shuffle() {
		game.shuffle()
	}
	
	func choose(_ card: MemoryGame<String>.Card) {
		game.choose(card)
	}
}
