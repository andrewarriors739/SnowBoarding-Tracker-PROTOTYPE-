//
//  AuthViewModel.swift
//  SnowBoarding Tracker (PROTOTYPE)
//
//  Created by Andre Rey Gutierrez on 4/15/25.
//

//
//  AuthViewModel.swift
//  SnowboardingTracker
//
//  Created by Jorge Barrera on 4/8/25.
//

import SwiftUI
import Supabase
import Observation

@Observable
class AuthViewModel {
    var userEmail = ""
    var userPassword = ""
    var isLoading = false
    var authResult: Result<Void, Error>?{
        didSet{
            if case .failure = authResult{
                showAlert = true
            }
        }
    }
    var showAlert = false
    var errorMessage: String?
    
    private func toggleLoadingState() {
        withAnimation {
            isLoading.toggle()
        }
    }
    
    @MainActor
    func signIn() async{
        toggleLoadingState()
        
        defer{ toggleLoadingState() }
        
        do{
            try await supabase.auth.signIn(
                email: userEmail,
                password: userPassword
              )
            authResult = .success(())
        } catch{
            authResult = .failure(error)
            errorMessage = error.localizedDescription
        }
    }
        
}

//t
