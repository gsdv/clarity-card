import SwiftUI
import UIKit

@main
struct MyApp: App {
    init() {
        let accent = UIColor(red: 0.14, green: 0.66, blue: 0.27, alpha: 1.0)
        if let backChevron = UIImage(systemName: "chevron.left")?.withTintColor(accent, renderingMode: .alwaysOriginal) {
            UINavigationBar.appearance().backIndicatorImage = backChevron
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backChevron
        }
        UINavigationBar.appearance().tintColor = accent
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
