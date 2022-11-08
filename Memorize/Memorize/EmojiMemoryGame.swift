import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String>
    var theme: Theme
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var score: String {
        return "\(model.score)"
    }
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let numberOfPairs = min(theme.pairs, theme.emojis.count)
        let emojis = Array(theme.emojis.shuffled()[0 ..< numberOfPairs])
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { _ in
//            String(emojis[pairIndex])
            "test"
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
