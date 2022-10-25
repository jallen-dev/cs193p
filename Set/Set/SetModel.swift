import Foundation

struct SetModel {
    private(set) var deck: [Card]
    private(set) var cardsInPlay: [Card]
    
    var selectedCardsAreMatchingSet: Bool {
        if selectedCards.count == 3 {
            return cardsFormASet(selectedCards)
        }
        
        return false
    }
    
    var selectedCardsAreInvalidSet: Bool {
        // note this is not simply !selectedCardsAreMatchingSet because sets of < 3 are neither
        if selectedCards.count == 3 {
            return !cardsFormASet(selectedCards)
        }
        
        return false
    }
    
    var selectedCards: [Card] {
        get {
            cardsInPlay.filter { card in
                card.selected
            }
        }
        set {
            for i in 0..<cardsInPlay.count {
                cardsInPlay[i].selected = false
            }
            for card in newValue {
                if let i = cardsInPlay.firstIndex(where: { $0.id == card.id }) {
                    cardsInPlay[i].selected = true
                }
            }
        }
    }
    
    init() {
        deck = [Card]()
        cardsInPlay = [Card]()
        var i = 0
        
        for color in ColorEnum.allCases {
            for number in NumberEnum.allCases {
                for shape in ShapeEnum.allCases {
                    for shading in ShadingEnum.allCases {
                        deck.append(Card(color: color, number: number, shape: shape, shading: shading, id: i))
                        i += 1
                    }
                }
            }
        }
        deck.shuffle()
        cardsInPlay.append(contentsOf: removeFromDeckAndReturn(12))
    }
    
    private mutating func removeFromDeckAndReturn(_ number: Int = 3) -> [Card] {
        if number > deck.count {
            return []
        }
        
        let cards = deck[0..<number]
        deck.removeFirst(number)
        return Array(cards)
    }
    
    mutating func draw() {
        let drawnCards = removeFromDeckAndReturn()
        
        // shouldn't happen because we disable the button when deck is empty but just in case
        if drawnCards.count == 0 {
            return
        }
        
        if selectedCardsAreMatchingSet {
            replaceSelectedCardsWith(drawnCards)
        } else {
            cardsInPlay.append(contentsOf: drawnCards)
        }
    }
    
    mutating func replaceSelectedCardsWith(_ newCards: [Card]) {
        var cardsToReplace: [Int] = []
        for selectedCard in selectedCards {
            if let index = cardsInPlay.firstIndex(where: { $0.id == selectedCard.id }) {
                cardsToReplace.append(index)
            }
        }
        
        for (index, card) in cardsToReplace.enumerated() {
            cardsInPlay[card] = newCards[index]
        }
    }
    
    mutating func choose(_ card: Card) {
        if selectedCardsAreMatchingSet {
            // try to replace the selected cards with new cards drawn from the deck
            let drawnCards = removeFromDeckAndReturn()
            if drawnCards.count > 2 {
                replaceSelectedCardsWith(drawnCards)
            } else {
                // there's no more cards in the deck, just remove without replacing
                cardsInPlay = cardsInPlay.filter { card in
                    card.id != selectedCards[0].id && card.id != selectedCards[1].id && card.id != selectedCards[2].id
                }
            }

            // if the card chosen was already selected, don't select anything. otherwise select it (requirement #8 C&D)
            if card.selected {
                selectedCards = []
            } else {
                selectedCards = [card]
            }
        } else if selectedCardsAreInvalidSet {
            // deselect them and select only this one
            selectedCards = [card]
        } else {
            // toggle this card's selection
            if let i = cardsInPlay.firstIndex(where: { $0.id == card.id }) {
                cardsInPlay[i].selected = !card.selected
            }
        }
    }
    
    private func cardsFormASet(_ cards: [Card]) -> Bool {
        return
            allMatchOrUnique(cards[0].number, cards[1].number, cards[2].number) &&
            allMatchOrUnique(cards[0].shading, cards[1].shading, cards[2].shading) &&
            allMatchOrUnique(cards[0].shape, cards[1].shape, cards[2].shape) &&
            allMatchOrUnique(cards[0].color, cards[1].color, cards[2].color)
    }
    
    private func allMatchOrUnique(_ value1: AnyHashable, _ value2: AnyHashable, _ value3: AnyHashable) -> Bool {
        return (value1 == value2 && value2 == value3) || (value1 != value2 && value1 != value3 && value2 != value3)
    }
    
    enum ShapeEnum: CaseIterable {
        case oval, squiggle, diamond
    }
    
    enum NumberEnum: Int, CaseIterable {
        case one = 1, two = 2, three = 3
    }
    
    enum ColorEnum: CaseIterable {
        case red, blue, green
    }
    
    enum ShadingEnum: CaseIterable {
        case solid, striped, open
    }
    
    struct Card: Identifiable {
        var selected = false
        var color: ColorEnum
        var number: NumberEnum
        var shape: ShapeEnum
        var shading: ShadingEnum
        var id: Int
    }
}
