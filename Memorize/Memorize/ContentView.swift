import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.theme.name)
                Text("\(viewModel.theme.color.red)")
                Text("\(viewModel.theme.color.green)")
                Text("\(viewModel.theme.color.blue)")
                Spacer()
                Text(viewModel.score)
            }.font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2 / 3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }.foregroundColor(Color(rgbaColor: viewModel.theme.color))
                .font(.largeTitle)

            Button {
                viewModel.newGame()
            } label: {
                Text("New Game")
                    .font(.title2)
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = Theme(name: "Halloween", emojis: "💀👻🎃👽👨‍🚀", pairs: 7, color: RGBAColor(color: Color(red: 0.8, green: 0.2, blue: 0.1)), id: 1)
        let game = EmojiMemoryGame(theme: theme)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
