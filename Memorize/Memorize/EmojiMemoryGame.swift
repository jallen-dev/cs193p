import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let numberOfPairs = min(theme.pairs, theme.emoji.count)
        let emojis = Array(theme.emoji.shuffled()[0..<numberOfPairs])
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    private(set) var theme: Theme
    
    init() {
        theme = Theme.random()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: String {
        return "\(model.score)"
    }
    
    var color: Color {
        switch theme.color {
        case "orange": return .orange
        case "purple": return .purple
        case "blue": return .blue
        case "yellow": return .yellow
        case "green": return .green
        case "brown": return .brown
        case "cyan": return .cyan
        case "pink": return .pink
        default: return .red
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = Theme.random()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
