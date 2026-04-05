import SwiftUI

struct DiaryEntryRow: View {
    let entry: DiaryEntry
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(entryTypeColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: entry.type.icon)
                    .foregroundColor(entryTypeColor)
                    .font(.system(size: 18, weight: .bold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(entry.type.rawValue)
                        .font(.headline)
                    Spacer()
                    Text(entry.timestamp.formattedTime)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if let food = entry.food, let portion = entry.portion {
                    Text("Food: \(food) (\(portion))")
                        .font(.subheadline)
                }
                
                if let start = entry.startTime, let end = entry.endTime {
                    Text("Slept: \(start.formattedTime) - \(end.formattedTime)")
                        .font(.subheadline)
                }
                
                if let nappy = entry.nappyType {
                    Text("Nappy: \(nappy)")
                        .font(.subheadline)
                }
                
                if !entry.note.isEmpty {
                    Text(entry.note)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .italic()
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    private var entryTypeColor: Color {
        switch entry.type {
        case .meal: return .mealColor
        case .sleep: return .sleepColor
        case .nappy: return .nappyColor
        case .mood: return .moodColor
        case .activity: return .activityColor
        }
    }
}
