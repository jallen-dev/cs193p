//
//  ThemeStore.swift
//  Memorize
//
//  Created by Justin Allen on 11/2/22.
//

import SwiftUI

struct Theme: Identifiable, Codable {
    var name: String
    var emojis: String
    var pairs: Int
    var color: RGBAColor
    var id: Int
}

class ThemeStore: ObservableObject {
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }

    init() {
//        restoreFromUserDefaults()
        if themes.isEmpty {
            insertTheme(name: "Halloween", emojis: "💀👻🎃👽👨‍🚀", pairs: 7, color: Color(red: 0.9, green: 0.5, blue: 0.2))
            insertTheme(name: "Weather", emojis: "☀️⛅️☁️🌧🌩🌨", pairs: 4, color: Color(red: 0.9, green: 0.1, blue: 0.9))
            insertTheme(name: "Animals", emojis: "🦒🐪🐄🐖🐅🐊🐘🦍🐏🐈🦌🐕🐓🐀", pairs: 8, color: Color(red: 0.9, green: 0.9, blue: 0.1))
            insertTheme(name: "Ocean", emojis: "🤿💦🦑🐠🐳", pairs: 5, color: Color(red: 0.1, green: 0.1, blue: 1))
            insertTheme(name: "Bugs", emojis: "🐛🪲🪰🐞🐝", pairs: 5, color: Color(red: 0.1, green: 1, blue: 0.1))
            insertTheme(name: "Farm", emojis: "🐴🐓🚜🐄🌾👨‍🌾🐇", pairs: 6, color: Color(red: 0.9, green: 0.1, blue: 0.1))
        }
    }

    private var userDefaultsKey: String {
        "themeStore"
    }

    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }

    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData)
        {
            themes = decodedThemes
        }
    }

    func insertTheme(name: String, emojis: String, pairs: Int, color: Color, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis, pairs: pairs, color: RGBAColor(color: color), id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
