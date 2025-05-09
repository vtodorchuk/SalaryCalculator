//
//  SalaryStratageView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI
import SwiftData

struct SalaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allocations: [Allocation]
    
    @AppStorage("defaultCurrency") private var currency: Currency = .usd
    @AppStorage("defaultSalary") private var salary: Double = 0
    @State private var isAddAllocationForm = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Group {
                    SalaryFormView(salary: $salary, currency: $currency)
                    separatorHorizontal
                    TotalBarView(salary: $salary, currency: $currency, isAddAllocationForm: $isAddAllocationForm)
                }
                .padding(.horizontal)
                
                if isAddAllocationForm {
                    AllocationFormView(salary: $salary, currency: $currency, isAddAllocationForm: $isAddAllocationForm)
                }
            
                AllocationsListView(currency: $currency, salary: $salary)
            }
            .fontDesign(.monospaced)
            .navigationTitle("Calculator")
            .toolbarTitleDisplayMode(.inline)
        }
    }
    
    var separatorHorizontal: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(.gray)
            .frame(maxWidth: .infinity)
            .frame(height: 2)
    }
}

#Preview {
    SalaryView()
        .modelContainer(for: Allocation.self, inMemory: true)
}
