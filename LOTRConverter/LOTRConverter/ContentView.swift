//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Ingyu Kim on 10/23/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var isLeftFocused: Bool
    @FocusState var isRightFocused: Bool
    
    @State var leftCurrency: Currency = .goldPiece
    @State var rightCurrency: Currency = .goldPenny
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack {
            // Background Image
            Image ("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // Prancing pony img
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                
                // Conversion section
                HStack {
                    // Left conversion section
                    VStack {
                        // Currency
                        HStack {
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                            
                            // Currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .sheet(isPresented: $showSelectCurrency) {
                            SelectCurrency(
                                selectedTopCurrency: $leftCurrency,
                                selectedBottomCurrency: $rightCurrency
                                
                            )
                        }
                        .onChange(of: leftCurrency) {
                            rightAmount = leftCurrency.converted(leftAmount, to: rightCurrency)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        // Text field
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($isLeftFocused)
                            .multilineTextAlignment(.center)
                            .onChange(of: leftAmount) {
                                if isLeftFocused {
                                    rightAmount = leftCurrency.converted(leftAmount, to: rightCurrency)
                                }
                            }
                            .keyboardType(.decimalPad)
                    }
                    .padding()
                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                        .symbolEffect(.pulse)
                    
                    // Right conversion section
                    VStack {
                        HStack {
                            // Currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(Color.white)
                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                        }
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .sheet(isPresented: $showSelectCurrency) {
                            SelectCurrency(
                                selectedTopCurrency: $leftCurrency,
                                selectedBottomCurrency: $rightCurrency
                                
                            )
                        }
                        .onChange(of: rightCurrency) {
                            leftAmount = rightCurrency.converted(rightAmount, to: leftCurrency)
                        }
                        .padding(.bottom, -5)
                        // Text field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .focused($isRightFocused)
                            .onChange(of: rightAmount) {
                                if isRightFocused {
                                    leftAmount = rightCurrency.converted(rightAmount, to: leftCurrency)
                                }
                            }
                            .keyboardType(.decimalPad)
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                    .fill(.black.opacity(0.5))
                )
                
//                .clipShape(.capsule)
                
                // Spacer
                Spacer()
                // info button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
//                        print("showExchangeInfo value: \(showExchangeInfo)")
                    } label: {
                        Label("", systemImage: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.trailing)
                    .sheet(isPresented: $showExchangeInfo) {
                        ExchangeInfo()
                    }
                    
                }
            }
//            .border(Color.white, width: 1)
        }
        .task {
            try? Tips.configure()
        }
    }
}

#Preview {
    ContentView()
}
