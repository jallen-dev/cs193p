import SwiftUI

@main
struct MemorizeApp: App {
    // TODO: don't do this
    let game = EmojiMemoryGame(theme: Theme(name: "Halloween", emojis: "💀👻🎃👽👨‍🚀", pairs: 7, color: RGBAColor(color: .orange), id: 1))

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
