//
//  SalaryFormView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI

struct SalaryFormView: View {
    @Binding var salary: Double
    @Binding var currency: Currency
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("Salary:")
            TextField("Your salary", value: $salary, format: .number)
                .keyboardType(.numbersAndPunctuation)
            Text(currency.rawValue)
        }
        .font(.title2)
        .foregroundStyle(.foreground)
    }
}
