import SwiftUI
import SwiftData

struct MyChildrenView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Child.name) private var children: [Child]
    @State private var viewModel: ChildViewModel?
    
    var body: some View {
        NavigationStack {
            Group {
                if filteredChildren.isEmpty {
                    ContentUnavailableView(
                        "No Children Found",
                        systemImage: "person.2.slash",
                        description: Text("Try searching for a different name or check your assignments.")
                    )
                } else {
                    List {
                        ForEach(filteredChildren) { child in
                            NavigationLink {
                                ChildDiaryView(child: child)
                            } label: {
                                ChildRow(child: child, hasAlert: viewModel?.hasMissingEntry(for: child) ?? false)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Children")
            .searchable(text: Binding(
                get: { viewModel?.searchText ?? "" },
                set: { viewModel?.searchText = $0 }
            ), prompt: "Search children...")
            .onAppear {
                if viewModel == nil {
                    viewModel = ChildViewModel(modelContext: modelContext)
                }
            }
        }
    }
    
    private var filteredChildren: [Child] {
        viewModel?.filteredChildren(children) ?? children
    }
}

#Preview {
    MyChildrenView()
        .modelContainer(for: Child.self, inMemory: true)
}
