//
//  ContentView.swift
//  SnowboardingTracker
//
//  Created by Jorge Barrera on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false
    
    var body: some View {
        Group{
            if isAuthenticated{
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                .padding()
            } else {
                LoginFormView()
            }
        }
        .task {
            for await state in supabase.auth.authStateChanges{
                if [.initialSession,.signedIn,.signedOut].contains(state.event) {
                    isAuthenticated = state.session != nil
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
//t
