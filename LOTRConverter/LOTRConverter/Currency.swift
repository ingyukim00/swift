//
//  Currency.swift
//  LOTRConverter
//
//  Created by Ingyu Kim on 10/24/25.
//

import SwiftUI

enum Currency: Double, CaseIterable, Identifiable {
    var id: Currency { self } // self is each of the cases
    case goldPiece = 1
    case goldPenny = 4
    case silverPiece = 16
    case silverPenny = 64
    case copperPenny = 6400
    
    var image: ImageResource {
        switch self {
        case .goldPiece:
            return .goldpiece
        case .goldPenny:
            return .goldpenny
        case .silverPiece:
            return .silverpiece
        case .silverPenny:
            return .silverpenny
        case .copperPenny:
            return .copperpenny
        }
    }
    
    var name: String {
        switch self {
        case .goldPiece:
            return "Gold Piece"
        case .goldPenny:
            return "Gold Penny"
        case .silverPiece:
            return "Silver Piece"
        case .silverPenny:
            return "Silver Penny"
        case .copperPenny:
            return "Copper Penny"
        }
    }
    
    func converted(_ amountString: String,to currency: Currency) -> String {
        guard let doubleAmount = Double(amountString) else {
            return ""
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        return String(format: "%.2f", convertedAmount)
    }
}
