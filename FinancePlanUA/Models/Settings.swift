//
//  Item.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import Foundation
import SwiftData

@Model
final class Settings {
    var defaultCurrency = Currency.usd
    
    init(defaultCurrency: Currency) {
        self.defaultCurrency = defaultCurrency
    }
}
