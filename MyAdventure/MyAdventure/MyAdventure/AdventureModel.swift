import Foundation

struct AdventureOption: Identifiable {
    let id = UUID()
    let title: String
    let nextNodeID: String?
    let success: Bool?
}

struct AdventureNode {
    let id: String
    let title: String
    let description: String
    let options: [AdventureOption]
}
