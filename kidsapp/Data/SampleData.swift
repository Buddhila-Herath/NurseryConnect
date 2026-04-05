import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    func seed(modelContext: ModelContext) {
        let fetchDescriptor = FetchDescriptor<Child>()
        do {
            let existingChildren = try modelContext.fetch(fetchDescriptor)
            if existingChildren.isEmpty {
                let noah = Child(name: "Noah", age: 3, allergies: ["Peanuts"], emergencyContact: "Dad: 0123456789", avatar: "👦")
                let lily = Child(name: "Lily", age: 2, allergies: ["Dairy"], emergencyContact: "Mom: 0987654321", avatar: "👧")
                let oliver = Child(name: "Oliver", age: 4, allergies: [], emergencyContact: "Grandma: 0112233445", avatar: "👶")
                
                modelContext.insert(noah)
                modelContext.insert(lily)
                modelContext.insert(oliver)
                
                // Add some initial entries for Noah
                let lunch = DiaryEntry(type: .meal, note: "Ate most of it", timestamp: Date(), food: "Pasta", portion: "Full")
                lunch.child = noah
                modelContext.insert(lunch)
                
                let nap = DiaryEntry(type: .sleep, note: "Slept well", timestamp: Date(), startTime: Calendar.current.date(byAdding: .hour, value: -2, to: Date()), endTime: Calendar.current.date(byAdding: .hour, value: -1, to: Date()))
                nap.child = noah
                modelContext.insert(nap)
                
                try? modelContext.save()
            }
        } catch {
            print("Failed to seed sample data: \(error)")
        }
    }
}
