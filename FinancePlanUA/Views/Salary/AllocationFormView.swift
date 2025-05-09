//
//  AllocationFormView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI
import SwiftData

struct AllocationFormView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var allocationPercentage: Double = 0
    @State private var allocationPurpose = ""
    
    @Query private var allocations: [Allocation]
    @Binding var salary: Double
    @Binding var currency: Currency
    @Binding var isAddAllocationForm: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Allocation:")
                    TextField("Allocation", value: $allocationPercentage, format: .percent)
                        .keyboardType(.decimalPad)
                }
                Divider()
                HStack {
                    Text("Purpose:")
                    TextField("", text: $allocationPurpose)
                }
                Divider()
                HStack {
                    Text("Amount:")
                    Text(salary * allocationPercentage, format: .currency(code: currency.rawValue.uppercased()))
                }
            }
            
            Button {
                withAnimation {
                    isAddAllocationForm.toggle()
                    
                    let newAllocation = Allocation(
                        percent: allocationPercentage,
                        purpose: allocationPurpose
                    )
                    modelContext.insert(newAllocation)
                    
                    allocationPercentage = 0
                    allocationPurpose = ""
                }
            } label: {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.primary)
                    .frame(height: 30)
                    .overlay {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.background)
                    }
            }
            
            Button {
                withAnimation() {
                    isAddAllocationForm.toggle()
                }
            } label: {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.primary)
                    .frame(height: 30)
                    .overlay {
                        Text("Cancel")
                            .foregroundStyle(.background)
                    }
            }
        }
        .foregroundStyle(.primary)
        .padding()
        .presentationDetents([.medium, .fraction(0.2)])
        .transition(.slide)
    }
}
