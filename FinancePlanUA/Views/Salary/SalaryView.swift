//
//  SalaryStratageView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI

struct SalaryStratageView: View {
    @State private var salaryViewModel = SalaryViewModel()
    
    @State private var currency: Currency = .usd
    @State private var salary: Double = 0
    
    @State private var isAddAllocationForm = false
    
    @State private var allocationPercentage: Double = 0
    @State private var allocationPurpose = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Group {
                    HStack(alignment: .bottom) {
                        Text("Salary:")
                        TextField("Salary:", value: $salary, format: .number)
                        Picker("", selection: $currency) {
                            ForEach(Currency.allCases, id: \.self) { currency in
                                Text(currency.rawValue).tag(currency.rawValue)
                            }
                        }
                        .pickerStyle(.palette)
                    }
                    .font(.title2)
                    .foregroundStyle(.foreground)
                    
                    separatorHorizontal
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            Text("Total Amount:")
                            Text(salaryViewModel.totalAmount(salary: salary), format: .currency(code: currency.rawValue.capitalized))
                        }
                        HStack(alignment: .bottom) {
                            Text("Total Percentage:")
                            Text(salaryViewModel.totalPercentage(salary: salary), format: .percent)
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
                .padding(.horizontal)
                
                if isAddAllocationForm {
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Allocation:")
                                TextField("Allocation", value: $allocationPercentage, format: .percent)
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
                                salaryViewModel.addAllocation(newAllocation: newAllocation)
                                
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
                        salaryViewModel.delete(indexSet: indexSet)
                    }
                }
                .listStyle(.plain)
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
    SalaryStratageView()
}
