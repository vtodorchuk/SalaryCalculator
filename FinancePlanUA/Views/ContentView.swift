//
//  ContentView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SalaryView()
                .tabItem {
                    Label("Calculator", systemImage: "pencil.and.list.clipboard")
                }
            Text("Transactions")
                .tabItem {
                    Label("Transactions", systemImage: "arrow.left.arrow.right")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
