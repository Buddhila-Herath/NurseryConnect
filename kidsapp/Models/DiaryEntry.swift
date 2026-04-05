import Foundation
import SwiftData

enum EntryType: String, Codable, CaseIterable {
    case meal = "Meal"
    case sleep = "Sleep"
    case nappy = "Nappy"
    case mood = "Mood"
    case activity = "Activity"
    
    var icon: String {
        switch self {
        case .meal: return "fork.knife"
        case .sleep: return "bed.double.fill"
        case .nappy: return "toilet.fill"
        case .mood: return "face.smiling.fill"
        case .activity: return "figure.run"
        }
    }
}

@Model
final class DiaryEntry: Identifiable {
    @Attribute(.unique) var id: UUID
    var type: EntryType
    var timestamp: Date
    var note: String
    
    // Meal details
    var food: String?
    var portion: String?
    
    // Sleep details
    var startTime: Date?
    var endTime: Date?
    
    // Nappy details
    var nappyType: String? // Dry, Wet, Soiled
    
    var child: Child?
    
    init(type: EntryType, note: String = "", timestamp: Date = Date(), food: String? = nil, portion: String? = nil, startTime: Date? = nil, endTime: Date? = nil, nappyType: String? = nil) {
        self.id = UUID()
        self.type = type
        self.note = note
        self.timestamp = timestamp
        self.food = food
        self.portion = portion
        self.startTime = startTime
        self.endTime = endTime
        self.nappyType = nappyType
    }
}
