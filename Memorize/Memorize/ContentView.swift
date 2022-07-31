import SwiftUI

struct ContentView: View {
    let vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚁", "🛶", "⛵️", "🚤", "🛳", "⛴", "🛥"]
    let sports = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🏓"]
    let food = ["🍎", "🍌", "🍉", "🍇", "🍓", "🍑", "🍒", "🥑", "🍆", "🌶", "🌽"]
    
    @State var emojis: [String]
    
    init() {
        self.emojis = vehicles.shuffled()
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }.foregroundColor(.red)
            Spacer()
            HStack(alignment: .bottom) {
                vehiclesButton
                Spacer()
                foodButton
                Spacer()
                sportsButton
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var foodButton: some View {
        Button {
            emojis = food.shuffled()
        } label: {
            VStack {
                Image(systemName: "fork.knife")
                Text("Food")
                    .font(.caption)
            }
        }
    }
    
    var sportsButton: some View {
        Button {
            emojis = sports.shuffled()
        } label: {
            VStack {
                Image(systemName: "sportscourt")
                Text("Sports")
                    .font(.caption)
            }
        }
    }
    
    var vehiclesButton: some View {
        Button {
            emojis = vehicles.shuffled()
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles")
                    .font(.caption)
            }
            
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
