import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel

    @State private var dealtCards = Set<Int>()

    @Namespace private var namespace

    var body: some View {
        GeometryReader { geometry in
            VStack {
                AspectVGrid(items: viewModel.cardsInPlay, aspectRatio: 2 / 3, content: { card in
                    CardView(card, matching: viewModel.cardsAreMatching, error: viewModel.cardsAreInvalid)
                        .overlay(viewModel.cardsAreMatching && card.selected ? .green.opacity(0.5) : .clear)
                        .rotationEffect(Angle.degrees(viewModel.cardsAreInvalid && card.selected ? 90 : 0))
                        .animation(Animation.easeInOut(duration: 0.5), value: viewModel.cardsAreMatching)
                        .animation(Animation.easeInOut(duration: 0.25), value: viewModel.cardsAreInvalid)
                        .matchedGeometryEffect(id: card.id, in: namespace)
                        .onTapGesture {
                            withAnimation {
                                viewModel.choose(card)
                            }
                        }
                })
                HStack {
                    deck.frame(width: geometry.size.height * 0.2 * 2 / 3)
                    Spacer()
                    discardPile.frame(width: geometry.size.height * 0.2 * 2 / 3)
                    Spacer()
                    Button {
                        viewModel.newGame()
                    } label: {
                        Text("New Game")
                            .font(.title2)
                    }
                }.frame(height: geometry.size.height * 0.2)
            }.padding()
        }
    }

    var deck: some View {
        ZStack {
            ForEach(viewModel.deck) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: namespace)
                    .offset(deckOffset(of: card))
                    .zIndex(zIndex(of: card))
            }
        }
        .onTapGesture {
            withAnimation {
                viewModel.draw()
            }
        }
    }

    var discardPile: some View {
        ZStack {
            ForEach(viewModel.discardPile) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: namespace)
                    .offset(discardOffset(of: card))
            }
        }
    }

    private func zIndex(of card: SetModel.Card) -> Double {
        -Double(viewModel.deck.firstIndex(where: { $0.id == card.id }) ?? 0)
    }

    private func deckOffset(of card: SetModel.Card) -> CGSize {
        let i = viewModel.deck.firstIndex(where: { $0.id == card.id }) ?? 0
        return CGSize(width: 0, height: min(viewModel.deck.count - i, 3) * -5)
    }

    private func discardOffset(of card: SetModel.Card) -> CGSize {
        let i = viewModel.discardPile.firstIndex(where: { $0.id == card.id }) ?? 0
        return CGSize(width: 0, height: min(i, 3) * -5)
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        SetView(viewModel: game)
    }
}
