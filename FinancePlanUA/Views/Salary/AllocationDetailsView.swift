//
//  AllocationDetailsView.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI

struct AllocationDetailsView: View {
    @State private var dragOffset: CGSize = .zero
    @State private var isDismissing = false
    
    @State var allocation: Allocation
    
    @Binding var selectedAllocation: Allocation?
    @Binding var salary: Double
    @Binding var currency: Currency
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(.thickMaterial.opacity(0.8))
            .frame(height: 120)
            .padding()
            .overlay {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(allocation.purpose.capitalized)
                        Text(allocation.percent, format: .percent)
                        Text(salary * allocation.percent, format: .currency(code: currency.rawValue.uppercased()))
                    }
                    Spacer()
                    VStack (alignment: .leading) {
                        Text("Transaction")
                            .bold()
                        
                        NavigationLink {
                            Text("Add")
                        } label: {
                            Label("Add", systemImage: "plus.app")
                        }
                        NavigationLink {
                            Text("View")
                        } label: {
                            Label("View", systemImage: "chevron.right.square")
                        }
                        
                    }
                }
                .foregroundStyle(.primary)
                .fontDesign(.monospaced)
                .padding()
                .padding(.horizontal, 20)
            }
            .offset(x: dragOffset.width)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        if abs(value.translation.width) > 100 {
                            withAnimation(.easeOut(duration: 0.3)) {
                                dragOffset.width = value.translation.width > 0 ? 500 : -500
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation {
                                    selectedAllocation = nil
                                    dragOffset = .zero
                                }
                            }
                        } else {
                            withAnimation {
                                dragOffset = .zero
                            }
                        }
                    }
            )
    }
}

#Preview {
    @Previewable @State var selectedAllocation: Allocation? = .init(percent: 100, purpose: "Investment")
    @Previewable @State var currency: Currency = .usd
    @Previewable @State var salary: Double = 1500
    
    AllocationDetailsView(allocation: selectedAllocation!, selectedAllocation: $selectedAllocation, salary: $salary, currency: $currency)
}
