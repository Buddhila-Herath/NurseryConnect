import Foundation
import SwiftData
import SwiftUI

@Observable
class ChildViewModel {
    var searchText: String = ""
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func filteredChildren(_ children: [Child]) -> [Child] {
        if searchText.isEmpty {
            return children
        } else {
            return children.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    func hasMissingEntry(for child: Child) -> Bool {
        // Simple logic: if no entries today, mark as missing
        let today = Calendar.current.startOfDay(for: Date())
        return !child.diaryEntries.contains { Calendar.current.isDate($0.timestamp, inSameDayAs: today) }
    }
}
