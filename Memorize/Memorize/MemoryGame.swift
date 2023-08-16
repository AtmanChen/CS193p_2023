//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Anderson  on 2023/8/16.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
	private(set) var cards: [Card]
	
	init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
		cards = []
		for pairIndex in 0..<max(2, numberOfPairsOfCards) {
			let content = cardContentFactory(pairIndex)
			cards.append(Card(content: content, id: "\(pairIndex+1)a"))
			cards.append(Card(content: content, id: "\(pairIndex+1)b"))
		}
	}
	
	mutating func choose(_ card: Card) {
		guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else {
			fatalError("Unknown Card: \(card.id)")
		}
		cards[chosenIndex].isFaceUp.toggle()
	}
	
	mutating func shuffle() {
		cards.shuffle()
		print(cards)
	}
	
	struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
		var debugDescription: String {
			"\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") "
		}
		
		var isFaceUp = true
		var isMatched = false
		let content: CardContent
		let id: String
	}
	
}
