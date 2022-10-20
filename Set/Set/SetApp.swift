import SwiftUI

@main
struct SetApp: App {
    let game = SetViewModel()

    var body: some Scene {
        WindowGroup {
            SetView(viewModel: game)
        }
    }
}
