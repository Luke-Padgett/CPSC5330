import SwiftUI

@main
struct MyAdventureApp: App {
    @StateObject private var controller = AdventureController()

    var body: some Scene {
        WindowGroup {
            ContentView(controller: controller)
        }
    }
}
