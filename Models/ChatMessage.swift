import Foundation
import SwiftData

@Model
final class ChatMessage {
    var id: UUID
    var text: String
    var timestamp: Date
    var isOutgoing: Bool
    var senderName: String
    var isDelivered: Bool
    
    init(id: UUID = UUID(), text: String, timestamp: Date = Date(), isOutgoing: Bool, senderName: String = "", isDelivered: Bool = true) {
        self.id = id
        self.text = text
        self.timestamp = timestamp
        self.isOutgoing = isOutgoing
        self.senderName = senderName
        self.isDelivered = isDelivered
    }
}
