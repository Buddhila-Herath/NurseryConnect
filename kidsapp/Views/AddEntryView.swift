import SwiftUI
import SwiftData

struct AddEntryView: View {
    let child: Child
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var type: EntryType = .meal
    @State private var timestamp = Date()
    @State private var note = ""
    
    // Conditional fields
    @State private var food = ""
    @State private var portion = "Full"
    @State private var startTime = Date()
    @State private var endTime = Date().addingTimeInterval(3600)
    @State private var nappyType = "Wet"
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let portions = ["Full", "Half", "Small", "None"]
    let nappyTypes = ["Dry", "Wet", "Soiled", "Both"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Entry Type") {
                    Picker("Activity", selection: $type) {
                        ForEach(EntryType.allCases, id: \.self) { type in
                            Label(type.rawValue, systemImage: type.icon)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    DatePicker("Time", selection: $timestamp)
                }
                
                Section("Details") {
                    switch type {
                    case .meal:
                        TextField("Food", text: $food)
                        Picker("Portion", selection: $portion) {
                            ForEach(portions, id: \.self) { Text($0) }
                        }
                    case .sleep:
                        DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                        DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                    case .nappy:
                        Picker("Type", selection: $nappyType) {
                            ForEach(nappyTypes, id: \.self) { Text($0) }
                        }
                    case .mood, .activity:
                        EmptyView()
                    }
                    
                    TextField("Notes (Optional)", text: $note, axis: .vertical)
                        .lineLimit(3...5)
                }
            }
            .navigationTitle("Add Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEntry()
                    }
                }
            }
            .alert("Wait!", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func saveEntry() {
        // Validation logic
        if type == .meal && food.isEmpty {
            alertMessage = "Please enter what the child ate."
            showAlert = true
            return
        }
        
        let newEntry = DiaryEntry(
            type: type,
            note: note,
            timestamp: timestamp,
            food: type == .meal ? food : nil,
            portion: type == .meal ? portion : nil,
            startTime: type == .sleep ? startTime : nil,
            endTime: type == .sleep ? endTime : nil,
            nappyType: type == .nappy ? nappyType : nil
        )
        
        newEntry.child = child
        modelContext.insert(newEntry)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            alertMessage = "Could not save entry: \(error.localizedDescription)"
            showAlert = true
        }
    }
}
