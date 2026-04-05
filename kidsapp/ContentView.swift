//
//  ContentView.swift
//  kidsapp
//
//  Created by Supun Liyanage on 3/20/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        MyChildrenView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Child.self, inMemory: true)
}
