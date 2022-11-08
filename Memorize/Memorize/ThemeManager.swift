//
//  ThemeManager.swift
//  Memorize
//
//  Created by Justin Allen on 11/3/22.
//

import SwiftUI

struct ThemeManager: View {
//    @EnvironmentObject var store: ThemeStore
//    let store = ThemeStore()

//    let games: [Int: EmojiMemoryGame]
    let games: [EmojiMemoryGame]

    var body: some View {
        NavigationView {
            List {
                ForEach(games, id: \.theme.id) { game in
                    NavigationLink(destination: ContentView(viewModel: game)) {
                        VStack(alignment: .leading) {
                            Text(game.theme.name).font(.title2).foregroundColor(Color(rgbaColor: game.theme.color))
                            Text(game.theme.emojis)
                        }
                    }
                }
            }
        }.navigationTitle("Memorize")
    }
}

struct ThemeManager_Previews: PreviewProvider {
//    let games = Dictionary(uniqueKeysWithValues: ThemeStore().themes.map { ($0.id, EmojiMemoryGame(theme: $0)) })
    static let games = ThemeStore().themes.map { EmojiMemoryGame(theme: $0) }

    static var previews: some View {
        ThemeManager(games: games)
    }
}
