//
//  AllocationsView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI
import SwiftData

struct AllocationsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allocations: [Allocation]
    
    @Binding var currency: Currency
    @Binding var salary: Double
    
    @State private var selectedAllocation: Allocation?
    
    var body: some View {
        List {
            ForEach(allocations) { allocation in
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(allocation.percent, format: .percent)
                        Text(salary * allocation.percent, format: .currency(code: currency.rawValue.uppercased()))
                    }
                    Spacer()
                    Text(allocation.purpose.capitalized)
                }
                .onTapGesture {
                    withAnimation {
                        selectedAllocation = allocation
                    }
                }
            }
            .onDelete { (indexSet) in
                withAnimation {
                    for index in indexSet {
                        modelContext.delete(allocations[index])
                    }
                }
            }
        }
        .listStyle(.plain)
        .safeAreaInset(edge: .bottom) {
            if let allocation = selectedAllocation {
                AllocationDetailsView(allocation: allocation, selectedAllocation: $selectedAllocation, salary: $salary, currency: $currency)
            }
        }
    }
}
