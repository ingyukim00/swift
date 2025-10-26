//
//  CurrencyIcon.swift
//  LOTRConverter
//
//  Created by Ingyu Kim on 10/23/25.
//

import SwiftUI

struct CurrencyIcon: View {
    var currencyImage: ImageResource
    var currencyName: String
    var body: some View {
        ZStack {
                // Currency Icons
                ZStack(alignment: .bottom) {
                    Image(currencyImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    // Currency name
                    Text(currencyName)
                        .padding(3)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .background(.brown.opacity(0.75))
                }
                .padding(3)
                .frame(width: 100, height: 100)
                .background(.brown)
                .clipShape(.rect(cornerRadius: 25))
//                .border(.red)
                }
        }
}

#Preview {
    CurrencyIcon(currencyImage: .goldpiece, currencyName: "Goldpiece")
}
