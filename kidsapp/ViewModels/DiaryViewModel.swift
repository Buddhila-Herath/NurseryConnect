import Foundation
import SwiftData
import SwiftUI

@Observable
class DiaryViewModel {
    var showOnlyToday: Bool = true
    var modelContext: ModelContext
    var child: Child
    
    init(modelContext: ModelContext, child: Child) {
        self.modelContext = modelContext
        self.child = child
    }
    
    var sortedEntries: [DiaryEntry] {
        let entries = child.diaryEntries.sorted { $0.timestamp > $1.timestamp }
        if showOnlyToday {
            return entries.filter { $0.timestamp.isToday }
        }
        return entries
    }
    
    func addEntry(type: EntryType, note: String, timestamp: Date, food: String? = nil, portion: String? = nil, startTime: Date? = nil, endTime: Date? = nil, nappyType: String? = nil) {
        let newEntry = DiaryEntry(
            type: type,
            note: note,
            timestamp: timestamp,
            food: food,
            portion: portion,
            startTime: startTime,
            endTime: endTime,
            nappyType: nappyType
        )
        newEntry.child = child
        modelContext.insert(newEntry)
        try? modelContext.save()
    }
    
    func deleteEntry(_ entry: DiaryEntry) {
        modelContext.delete(entry)
        try? modelContext.save()
    }
}
