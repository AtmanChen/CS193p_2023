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
	
	var indexOfTheOneAndFaceUpCard: Int? {
		get { cards.indices.filter { index in cards[index].isFaceUp }.only }
		set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
	}
	
	mutating func choose(_ card: Card) {
		guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else {
			fatalError("Unknown Card: \(card.id)")
		}
		print("\(chosenIndex) \(String(describing: indexOfTheOneAndFaceUpCard))")
		if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
			if let potentialMatchIndex = indexOfTheOneAndFaceUpCard {
				if cards[chosenIndex].content == cards[potentialMatchIndex].content {
					cards[chosenIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true
				}
			} else {
				indexOfTheOneAndFaceUpCard = chosenIndex
			}
			cards[chosenIndex].isFaceUp = true
		}
	}
	
	mutating func shuffle() {
		cards.shuffle()
		print(cards)
	}
	
	struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
		var debugDescription: String {
			"\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") "
		}
		
		var isFaceUp = false
		var isMatched = false
		let content: CardContent
		let id: String
	}
	
}

extension Array {
	var only: Element? {
		count == 1 ? first : nil
	}
}
