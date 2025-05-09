//
//  SalaryStratageView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI

struct SalaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var salaryViewModel = SalaryViewModel()
    
    @State private var currency: Currency = .usd
    @State private var salary: Double = 0
    @State private var isAddAllocationForm = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Group {
                    SalaryFormView(salary: $salary, currency: $currency)
                    separatorHorizontal
                    TotalBarView(salaryViewModel: $salaryViewModel, salary: $salary, currency: $currency, isAddAllocationForm: $isAddAllocationForm)
                }
                .padding(.horizontal)
                
                if isAddAllocationForm {
                    AllocationFormView(salary: $salary, currency: $currency, isAddAllocationForm: $isAddAllocationForm, salaryViewModel: $salaryViewModel)
                }
            
                AllocationsListView(salaryViewModel: $salaryViewModel, currency: $currency, salary: $salary)
            }
            .fontDesign(.monospaced)
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
