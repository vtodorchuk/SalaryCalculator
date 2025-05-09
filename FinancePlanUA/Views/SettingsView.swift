//
//  SettingsView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("defaultCurrency") private var defaultCurrency: Currency = .usd
    @AppStorage("isBiometricAuthentication") private var isBiometricAuthentication = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Default Currency") {
                    HStack {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.green.secondary)
                            .frame(width: 30, height: 30)
                            .overlay {
                                Image(systemName: "bitcoinsign.circle")
                                    .foregroundStyle(.primary)
                            }
                        
                        Picker("Currency", selection: $defaultCurrency) {
                            ForEach(Currency.allCases, id: \.self) { currency in
                                Text(currency.rawValue).tag(currency.rawValue)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                }
                
                Section("Security") {
                    HStack {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.yellow.secondary)
                            .frame(width: 30, height: 30)
                            .overlay {
                                Image(systemName: "faceid")
                                    .foregroundStyle(.primary)
                            }
                        Text("Use Biometric")
                        Toggle("", isOn: $isBiometricAuthentication)
                    }
                }
            }
            .navigationTitle("Settings")
            .fontDesign(.monospaced)
        }
    }
}

#Preview {
    SettingsView()
}
