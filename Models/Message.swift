import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    let text: String
    let timestamp: Date
    let isOutgoing: Bool
    let senderName: String
    
    init(id: UUID = UUID(), text: String, timestamp: Date = Date(), isOutgoing: Bool, senderName: String = "") {
        self.id = id
        self.text = text
        self.timestamp = timestamp
        self.isOutgoing = isOutgoing
        self.senderName = senderName
    }
}
