//
//  IconGrid.swift
//  LOTRConverter
//
//  Created by Ingyu Kim on 10/23/25.
//

import SwiftUI

struct IconGrid: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCurrency: Currency
    
    var body: some View {
        ZStack {
                // Currency Icons
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(Currency.allCases) { currency in
                        CurrencyIcon(currencyImage: currency.image,
                                     currencyName: currency.name)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedCurrency = currency
                            }
                        }
                            .shadow(color: .black, radius: 10)
                            .overlay(
                                Group {
                                    if selectedCurrency == currency {
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(lineWidth: 3)
                                            .opacity(0.5)
                                    }
                                }
                            )
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var selectedCurrency: Currency = .goldPiece
    IconGrid(selectedCurrency: $selectedCurrency)
}
