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
    
    @State private var dragOffset: CGSize = .zero
    @State private var isDismissing = false
    
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
                                
                                Button("Add", systemImage: "plus.app") {
                                    
                                }
                                Button("View", systemImage: "chevron.right.square") {
                                    
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
    }
}
