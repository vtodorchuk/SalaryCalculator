//
//  AllocationsView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI

struct AllocationsListView: View {
    @Binding var salaryViewModel: SalaryViewModel
    @Binding var currency: Currency
    @Binding var salary: Double
    
    var body: some View {
        List {
            ForEach(salaryViewModel.allocations) { allocation in
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(allocation.percent, format: .percent)
                        Text(salary * allocation.percent, format: .currency(code: currency.rawValue.uppercased()))
                    }
                    Spacer()
                    Text(allocation.purpose.capitalized)
                }
            }
            .onDelete { (indexSet) in
                withAnimation {
                    salaryViewModel.delete(indexSet: indexSet)
                }
            }
        }
        .listStyle(.plain)
    }
}
