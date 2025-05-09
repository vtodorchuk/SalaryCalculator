//
//  Allocation.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import Foundation
import SwiftData

@Model
final class Allocation: Identifiable {
    var id = UUID()
    
    var percent: Double
    var purpose: String
    
    init(percent: Double, purpose: String) {
        self.percent = percent
        self.purpose = purpose
    }
}

enum Currency: String, CaseIterable, Codable {
    case usd = "USD"
    case euro = "EUR"
    case uah = "UAH"
    
    func getCurrency(_ string: String) -> Currency {
        switch string {
            case "USD":
            return .usd
        case "EUR":
            return .euro
        case "UAH":
            return .uah
        default:
            return .usd
        }
    }
}
