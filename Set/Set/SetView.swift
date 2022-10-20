import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel

    var body: some View {
        VStack {
            AspectVGrid(items: viewModel.cards, aspectRatio: 2 / 3, content: { card in
                CardView(card, matching: viewModel.cardsAreMatching, error: viewModel.cardsAreInvalid).onTapGesture {
                    viewModel.choose(card)
                }
            })
            HStack {
                Button {
                    viewModel.draw()
                } label: {
                    Text("Draw 3 Cards")
                        .font(.title2)
                }.disabled(viewModel.isDeckEmpty)
                Spacer()
                Button {
                    viewModel.newGame()
                } label: {
                    Text("New Game")
                        .font(.title2)
                }
            }
        }.padding()
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        SetView(viewModel: game)
    }
}
