import Foundation
import SwiftData

@Model
final class Child: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var age: Int
    var allergies: [String]
    var emergencyContact: String
    var avatar: String // Emoji or image name
    
    @Relationship(deleteRule: .cascade, inverse: \DiaryEntry.child)
    var diaryEntries: [DiaryEntry] = []
    
    init(name: String, age: Int, allergies: [String] = [], emergencyContact: String = "", avatar: String = "👶") {
        self.id = UUID()
        self.name = name
        self.age = age
        self.allergies = allergies
        self.emergencyContact = emergencyContact
        self.avatar = avatar
    }
}
