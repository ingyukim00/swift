//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Ingyu Kim on 10/23/25.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTopCurrency: Currency
    @Binding var selectedBottomCurrency: Currency
    
    var body: some View {
        ZStack {
            // Parchment background img
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(Color.brown)
            VStack {
                // Text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                // Currency Icons
                IconGrid(selectedCurrency: $selectedTopCurrency)

                // Text
                Text("Select the currency you would like to convert to: ")
                    .fontWeight(.bold)
                    .padding(.top)
                // Currency Icons
                IconGrid(selectedCurrency: $selectedBottomCurrency)
                // Done btn
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    @Previewable @State var topCurrency: Currency = .goldPiece
    @Previewable @State var bottomCurrency: Currency = .goldPenny
    SelectCurrency(selectedTopCurrency: $topCurrency, selectedBottomCurrency: $bottomCurrency)
}
