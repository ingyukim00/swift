//
//  ContentView.swift
//  BBQuotes
//
//  Created by Ingyu Kim on 10/27/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise") {
                QuoteView(show: "Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
            
            Tab("Better Call Saul", systemImage: "briefcase") {
                QuoteView(show: "Better Call Saul")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
