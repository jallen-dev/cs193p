import Foundation

struct Theme {
    var name: String
    var emoji: [String]
    var pairs: Int
    var color: String
    
    static func random() -> Theme {
        Theme.allThemes.randomElement() ?? Theme.allThemes[0]
    }
    
    // Note: the first theme purposely has more `pairs` than available emoji (Required #7)
    static let allThemes = [
        Theme(name: "Halloween", emoji: ["💀","👻","🎃","👽","👨‍🚀"], pairs: 7, color: "orange"),
        Theme(name: "Weather", emoji: ["☀️", "⛅️", "☁️", "🌧", "🌩", "🌨"], pairs: 4, color: "purple"),
        Theme(name: "Animals", emoji: ["🦒", "🐪", "🐄", "🐖", "🐅", "🐊", "🐘", "🦍", "🐏", "🐈", "🦌", "🐕", "🐓", "🐀"], pairs: 8, color: "yellow"),
        Theme(name: "Ocean", emoji: ["🤿", "💦", "🦑", "🐠", "🐳"], pairs: 5, color: "blue"),
        Theme(name: "Bugs", emoji: ["🐛", "🪲", "🪰", "🐞", "🐝"], pairs: 5, color: "green"),
        Theme(name: "Farm", emoji: ["🐴", "🐓", "🚜", "🐄", "🌾", "👨‍🌾", "🐇"], pairs: 6, color: "red"),
    ]
}
