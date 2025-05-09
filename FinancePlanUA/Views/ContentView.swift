//
//  ContentView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @AppStorage("isBiometricAuthentication") private var isBiometricAuthentication = false
    @State private var isUnlocked = false
    @State private var isError = false
    
    var body: some View {
        TabView {
            if isUnlocked {
                SalaryView()
                    .tabItem {
                        Label("Calculator", systemImage: "pencil.and.list.clipboard")
                    }
                TransactionsView()
                    .tabItem {
                        Label("Transactions", systemImage: "arrow.left.arrow.right")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            } else {
                if isError {
                    Button("Try Again", systemImage: "faceid") {
                        authentica()
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .onAppear {
            if isBiometricAuthentication {
                authentica()
            } else {
                isUnlocked = true
            }
        }
    }
    
    func authentica() {
        let context = LAContext()
        var errors: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &errors) {
            let reasone = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasone) { success, errors in
                if success {
                    isUnlocked = true
                } else {
                    isUnlocked = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
