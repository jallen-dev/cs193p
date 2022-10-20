import Foundation

class SetViewModel: ObservableObject {
    @Published private var model: SetModel
    
    init() {
        model = SetModel()
    }
    
    var cards: [SetModel.Card] {
        model.cardsInPlay
    }
    
    var isDeckEmpty: Bool {
        model.deck.isEmpty
    }
    
    var cardsAreMatching: Bool {
        model.selectedCardsAreMatchingSet
    }
    
    var cardsAreInvalid: Bool {
        model.selectedCardsAreInvalidSet
    }
    
    // MARK: - Intents
    
    func choose(_ card: SetModel.Card) {
        model.choose(card)
    }
    
    func draw() {
        model.draw()
    }
    
    func newGame() {
        model = SetModel()
    }
}
