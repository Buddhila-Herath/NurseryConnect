import SwiftUI
import SwiftData

struct ChildDiaryView: View {
    let child: Child
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: DiaryViewModel?
    @State private var showAddEntry = false
    @State private var showEmergencyAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Child Info Header
            HStack {
                Text(child.avatar)
                    .font(.largeTitle)
                VStack(alignment: .leading) {
                    Text(child.name)
                        .font(.title2.bold())
                    Text("\(child.age) years old")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button {
                    showEmergencyAlert = true
                } label: {
                    Image(systemName: "phone.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .shadow(color: .black.opacity(0.05), radius: 5, y: 5)
            
            // Allergy Banner
            if !child.allergies.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text("Allergies: \(child.allergies.joined(separator: ", "))")
                        .font(.caption.bold())
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.red.opacity(0.1))
                .foregroundColor(.red)
            }
            
            // Timeline
            List {
                Section {
                    Toggle("Show Today Only", isOn: Binding(
                        get: { viewModel?.showOnlyToday ?? true },
                        set: { viewModel?.showOnlyToday = $0 }
                    ))
                    .font(.subheadline)
                }
                
                Section("Timeline") {
                    if let sortedEntries = viewModel?.sortedEntries, !sortedEntries.isEmpty {
                        ForEach(sortedEntries) { entry in
                            DiaryEntryRow(entry: entry)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel?.deleteEntry(entry)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    } else {
                        ContentUnavailableView(
                            "No Records",
                            systemImage: "calendar.badge.exclamationmark",
                            description: Text("No entries found for this period.")
                        )
                    }
                }
            }
        }
        .navigationTitle("Diary")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddEntry = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
            }
        }
        .sheet(isPresented: $showAddEntry) {
            AddEntryView(child: child)
        }
        .alert("Emergency Contact", isPresented: $showEmergencyAlert) {
            Button("Call \(child.emergencyContact.components(separatedBy: ":").first ?? "Contact")", role: .none) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(child.emergencyContact)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = DiaryViewModel(modelContext: modelContext, child: child)
            }
        }
    }
}
