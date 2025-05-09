//
//  TotalBarView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI
import SwiftData

struct TotalBarView: View {
    @Query private var allocations: [Allocation]
    
    @Binding var salary: Double
    @Binding var currency: Currency
    @Binding var isAddAllocationForm: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("Total Amount:")
                Text(totalAmount(), format: .currency(code: currency.rawValue.capitalized))
                    .contentTransition(.numericText(value: totalAmount()))
            }
            HStack(alignment: .bottom) {
                Text("Total Percentage:")
                Text(totalPercentage(), format: .percent)
                    .contentTransition(.numericText(value: totalPercentage()))
            }
        }
        .padding(.vertical)
        
        HStack(alignment: .bottom) {
            Text("Allocation")
                .font(.headline)
            
            Spacer()
            
            Button("Add", systemImage: "plus.circle") {
                withAnimation {
                    isAddAllocationForm.toggle()
                }
            }
            .foregroundStyle(.primary)
        }
    }
    
    func totalAmount() -> Double {
        allocations.reduce(into: 0) { result, allocation in
            result += salary * allocation.percent
        }
    }
    
    func totalPercentage() -> Double {
        allocations.reduce(into: 0) { result, allocation in
            result += allocation.percent
        }
    }
}
